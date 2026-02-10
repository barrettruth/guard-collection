describe('ktfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('ktfmt', 'kt', {
      [[fun main(){val x=1;println(x)}]],
    })
    assert.is_true(#formatted > 1)
    assert.is_true(formatted[1]:find('fun main') ~= nil)
  end)
end)
