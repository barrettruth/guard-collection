describe('shfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('shfmt', 'sh', {
      [[#!/bin/sh]],
      [[if [ "$x" = "y" ]; then]],
      [[echo "hello"]],
      [[fi]],
    })
    assert.are.same({
      [[#!/bin/sh]],
      [[if [ "$x" = "y" ]; then]],
      '\techo "hello"',
      [[fi]],
    }, formatted)
  end)
end)
