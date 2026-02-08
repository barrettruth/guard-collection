describe('mixformat', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('mixformat', 'ex', {
      [[defmodule Foo do  def bar(  x,y) do  x+y end end]],
    })
    assert.is_true(#formatted > 0)
    assert.is_true(formatted[1]:find('defmodule Foo') ~= nil)
  end)
end)
