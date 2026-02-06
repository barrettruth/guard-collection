describe('cpplint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('cpplint')
    local tmpfile = '/tmp/guard-test.cpp'
    local input = { [[int main(){int x=1;}]] }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim.system({ 'cpplint', '--filter=-legal/copyright', tmpfile }, {}):wait()
    local output = result.stderr or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('cpplint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
