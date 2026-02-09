describe('selene', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('selene', 'lua', {
      [[print(a)]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'selene',
      severity = vim.diagnostic.severity.ERROR,
      message_pat = 'not defined',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('selene', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
