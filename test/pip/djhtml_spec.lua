describe('djhtml', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('djhtml', 'html', {
      [[<div>]],
      [[<p>hello</p>]],
      [[</div>]],
    })
    assert.are.same({
      [[<div>]],
      [[    <p>hello</p>]],
      [[</div>]],
    }, formatted)
  end)
end)
