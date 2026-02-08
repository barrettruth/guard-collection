describe('zsh', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('zsh')
    local tmpfile = '/tmp/guard-test.zsh'
    vim.fn.writefile({ 'if true; then' }, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim.system({ 'zsh', '-n', tmpfile }, {}):wait()
    local output = result.stderr or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('zsh', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
