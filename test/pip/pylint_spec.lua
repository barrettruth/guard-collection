describe('pylint', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('pylint')

    local buf, diagnostics = helper.test_with('python', {
      [[x = 1]],
    })
    assert.is_true(#diagnostics > 0)
    assert.are.equal('pylint', diagnostics[1].source)
  end)
end)
