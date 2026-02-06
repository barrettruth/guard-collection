describe('prettier', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('prettier', 'javascript', {
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
