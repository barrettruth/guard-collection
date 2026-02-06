describe('cbfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('cbfmt', 'markdown', {
      [[# Title]],
      [[]],
      [[Some text.]],
    })
    assert.are.same({
      [[# Title]],
      [[]],
      [[Some text.]],
    }, formatted)
  end)
end)
