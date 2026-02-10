describe('fnlfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('fnlfmt', 'fnl', {
      [[(fn hello []  (print "hello"]],
      [[))]],
    })
    assert.is_true(#formatted > 0)
    assert.is_true(formatted[1]:find('fn hello') ~= nil)
  end)
end)
