describe('golangci_lint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('golangci_lint')
    local tmpdir = '/tmp/golangci-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({ 'module test', '', 'go 1.21' }, tmpdir .. '/go.mod')
    local input = {
      'package main',
      '',
      'import "fmt"',
      '',
      'func main() {',
      '\tfmt.Errorf("unused error")',
      '}',
    }
    vim.fn.writefile(input, tmpdir .. '/main.go')
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'golangci-lint',
        'run',
        '--fix=false',
        '--out-format=json',
      }, {
        cwd = tmpdir,
      })
      :wait()
    local output = result.stdout or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
