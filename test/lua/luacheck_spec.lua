describe('luacheck', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('luacheck', 'lua', {
      [[local M = {}]],
      [[function M.foo()]],
      [[  print("foo")]],
      [[end]],
      [[U.bar()]],
      [[return M]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'luacheck',
      severity = vim.diagnostic.severity.WARN,
      code = '113',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('luacheck', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
