describe('zigfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('zigfmt', 'zig', {
      [[const    std   =   @import(   "std"   );]],
    })
    assert.are.same({
      [[const std = @import("std");]],
    }, formatted)
  end)
end)
