describe('ruff_fix', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('ruff_fix', 'py', {
      [[import os]],
      [[import sys]],
      [[]],
      [[print(sys.argv)]],
    })
    assert.are.same({
      [[import sys]],
      [[]],
      [[print(sys.argv)]],
    }, formatted)
  end)
end)
