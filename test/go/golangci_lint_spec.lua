describe('golangci_lint', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-golangci-lint-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      'module testmod',
      '',
      'go 1.21',
    }, tmpdir .. '/go.mod')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('golangci_lint', 'go', {
      'package main',
      '',
      'import "fmt"',
      '',
      'func main() {',
      '\tfmt.Errorf("unused error")',
      '}',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
