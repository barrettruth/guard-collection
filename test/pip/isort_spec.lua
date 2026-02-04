describe('isort', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('python'):fmt('isort')

    local formatted = require('test.fmt_helper').test_with('python', {
      [[import sys]],
      [[import os]],
    })
    assert.are.same({
      [[import os]],
      [[import sys]],
    }, formatted)
  end)
end)
