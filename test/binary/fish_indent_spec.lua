describe('fish_indent', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('fish_indent', 'fish', {
      [[if test "$x" = "y"]],
      [[echo hello]],
      [[end]],
    })
    assert.are.same({
      [[if test "$x" = y]],
      [[    echo hello]],
      [[end]],
    }, formatted)
  end)
end)
