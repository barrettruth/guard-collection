describe('mdformat', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('mdformat', 'markdown', {
      [[#   title]],
      [[text]],
    })
    assert.are.same({
      [[# title]],
      [[]],
      [[text]],
    }, formatted)
  end)
end)
