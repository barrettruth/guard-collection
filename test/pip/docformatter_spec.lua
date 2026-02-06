describe('docformatter', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('docformatter', 'python', {
      [[def foo():]],
      [[    """]],
      [[    Hello foo.]],
      [[    """]],
      [[    if True:]],
      [[        x = 1]],
    })
    assert.are.same({
      [[def foo():]],
      [[    """Hello foo."""]],
      [[    if True:]],
      [[        x = 1]],
    }, formatted)
  end)
end)
