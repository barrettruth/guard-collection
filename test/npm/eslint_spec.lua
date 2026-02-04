describe('eslint', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('javascript'):lint('eslint')

    local buf, diagnostics = helper.test_with('javascript', {
      [[var x = 1]],
    })
    assert.is_true(#diagnostics > 0)
    assert.are.equal('eslint', diagnostics[1].source)
  end)
end)
