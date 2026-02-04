describe('mypy', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('python'):lint('mypy')

    local buf, diagnostics = helper.test_with('python', {
      [[def foo(x: int) -> str:]],
      [[    return x]],
    })
    assert.is_true(#diagnostics > 0)
    assert.are.equal('mypy', diagnostics[1].source)
  end)
end)
