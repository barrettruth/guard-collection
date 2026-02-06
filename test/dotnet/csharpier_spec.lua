describe('csharpier', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('csharpier', 'cs', {
      [[class A{void M(){int x=1;}}]],
    })
    assert.is_true(#formatted > 1)
    assert.is_true(formatted[1]:find('class A') ~= nil)
  end)
end)
