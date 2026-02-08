describe('swift-format', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('swift-format', 'swift', {
      [[func foo(  ){let x=1;print(x)}]],
    })
    assert.is_true(#formatted > 0)
    assert.is_true(formatted[1]:find('func foo') ~= nil)
  end)
end)
