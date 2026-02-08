describe('isort', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('isort', 'python', {
      [[import sys]],
      [[import os]],
      [[import json]],
    })
    assert.are.same({
      [[import json]],
      [[import os]],
      [[import sys]],
    }, formatted)
  end)
end)
