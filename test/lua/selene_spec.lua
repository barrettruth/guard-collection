describe('selene', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('selene', 'lua', {
      [[print(a)]],
    })
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('selene', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
