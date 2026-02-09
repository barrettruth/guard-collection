describe('hadolint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('hadolint', 'dockerfile', {
      [[FROM ubuntu]],
      [[RUN apt-get install python]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'hadolint',
      severity = vim.diagnostic.severity.WARN,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('hadolint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
