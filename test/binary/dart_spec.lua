describe('dart', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('dart', 'dart', {
      [[void main(){print('hello');}]],
    })
    assert.is_true(#formatted > 1)
    assert.is_true(formatted[1]:find('void main') ~= nil)
  end)
end)
