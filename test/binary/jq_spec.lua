describe('jq', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('jq', 'json', {
      [[{"b":2,"a":1}]],
    })
    assert.are.same({
      [[{]],
      [[  "b": 2,]],
      [[  "a": 1]],
      [[}]],
    }, formatted)
  end)
end)
