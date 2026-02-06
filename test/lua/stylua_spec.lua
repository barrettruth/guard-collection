describe('stylua', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('stylua', 'lua', {
      [[local M={}]],
      [[   M.foo  =]],
      [[  "foo"]],
      [[return        M]],
    })
    assert.are.same({
      [[local M = {}]],
      [[M.foo = 'foo']],
      [[return M]],
    }, formatted)
  end)
end)
