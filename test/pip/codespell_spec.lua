describe('codespell', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('codespell', 'txt', {
      [[teh quick brown fox]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'codespell',
      severity = vim.diagnostic.severity.WARN,
      message_pat = 'the',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('codespell', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
