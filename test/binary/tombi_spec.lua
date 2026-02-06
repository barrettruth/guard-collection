describe('tombi', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('tombi', 'toml', {
      '[package]',
      'name="test"',
      'version  =   "0.1.0"',
    })
    assert.is_true(#formatted > 0)
    for _, line in ipairs(formatted) do
      if line:find('name') then
        assert.is_true(line:find('name = ') ~= nil)
        break
      end
    end
  end)
end)
