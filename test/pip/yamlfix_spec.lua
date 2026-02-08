describe('yamlfix', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('yamlfix', 'yaml', {
      [[name:   John]],
      [[age:    30]],
    })
    assert.are.same({
      [[---]],
      [[name: John]],
      [[age: 30]],
    }, formatted)
  end)
end)
