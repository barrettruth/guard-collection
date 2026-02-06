describe('npm_groovy_lint', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('npm_groovy_lint', 'groovy', {
      [[class Foo{def bar(){println  "hello"}}]],
    })
    assert.is_true(#formatted > 0)
  end)

  it('can fix', function()
    local formatted = require('test.helper').run_fmt('npm_groovy_lint_fix', 'groovy', {
      [[class Foo{def bar(){println  "hello"}}]],
    })
    assert.is_true(#formatted > 0)
  end)
end)
