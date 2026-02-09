describe('cpplint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local linter = helper.get_linter('cpplint')
    local tmpfile = '/tmp/guard-test.cpp'
    local input = { [[int main(){int x=1;}]] }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim.system({ 'cpplint', '--filter=-legal/copyright', tmpfile }, {}):wait()
    local output = result.stderr or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'cpplint',
      severity = vim.diagnostic.severity.ERROR,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('cpplint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
