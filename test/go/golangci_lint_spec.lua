describe('golangci_lint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local tmpdir = '/tmp/golangci-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({ 'module test', '', 'go 1.21' }, tmpdir .. '/go.mod')
    local buf, diagnostics = helper.run_lint('golangci_lint', 'go', {
      'package main',
      '',
      'import "fmt"',
      '',
      'func main() {',
      '\tfmt.Errorf("unused error")',
      '}',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      severity = vim.diagnostic.severity.WARN,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
