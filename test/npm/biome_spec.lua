describe('biome', function()
  it('can format json', function()
    local formatted = require('test.helper').run_fmt('biome', 'json', {
      [[{"name":   "dove" , "age":10 ]],
      [[,"gender":   "male"}]],
    })
    assert.are.same({
      [[{ "name": "dove", "age": 10, "gender": "male" }]],
    }, formatted)
  end)

  it('can format javascript', function()
    local formatted = require('test.helper').run_fmt('biome', 'js', {
      [[            const randomNumber = Math.floor(]],
      [[      Math.random() *           10]],
      [[      ) + 1]],
      [[alert(randomNumber)]],
    })
    assert.are.same({
      [[const randomNumber = Math.floor(Math.random() * 10) + 1;]],
      [[alert(randomNumber);]],
    }, formatted)
  end)
end)
