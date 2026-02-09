describe('pylint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('pylint', 'py', {
      [[import os]],
      [[x = 1]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'pylint',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('pylint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
