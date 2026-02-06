describe('swiftformat', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('swiftformat', 'swift', {
      [[func myFunc()        { ]],
      [[print("hello")  ]],
      [[  }]],
    })
    assert.are.same({
      [[func myFunc() {]],
      [[    print("hello")]],
      [[}]],
    }, formatted)
  end)
end)
