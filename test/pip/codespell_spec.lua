describe('codespell', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('codespell', 'txt', {
      [[teh quick brown fox]],
    })
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('codespell', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
