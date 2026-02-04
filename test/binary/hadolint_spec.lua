describe('hadolint', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('dockerfile'):lint('hadolint')

    local buf, diagnostics = helper.test_with('dockerfile', {
      [[FROM ubuntu]],
      [[RUN apt-get update]],
    })
    assert.is_true(#diagnostics > 0)
    assert.are.equal('hadolint', diagnostics[1].source)
  end)
end)
