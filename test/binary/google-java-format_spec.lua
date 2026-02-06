describe('google-java-format', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('google-java-format', 'java', {
      'class A{void m(){int x=1;}}',
    })
    assert.is_true(#formatted > 1)
    assert.is_true(formatted[1]:find('class A') ~= nil)
  end)
end)
