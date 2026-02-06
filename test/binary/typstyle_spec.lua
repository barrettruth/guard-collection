describe('typstyle', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('typstyle', 'typ', {
      [[#let x =    1]],
    })
    assert.are.same({
      [[#let x = 1]],
    }, formatted)
  end)
end)
