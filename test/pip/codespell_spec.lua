describe('codespell', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('text'):lint('codespell')

    local buf, diagnostics = helper.test_with('text', {
      [[teh quick brown fox]],
    })
    assert.is_true(#diagnostics > 0)
    assert.are.equal('codespell', diagnostics[1].source)
  end)
end)
