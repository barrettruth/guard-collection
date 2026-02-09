describe('ruff', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('ruff', 'python', {
      [[def foo(n):]],
      [[    if n in         (1,2,3):]],
      [[        return n+1]],
      [[a, b = 1,    2]],
      [[b, a =     a, b]],
      [[print(  f"The factorial of {a} is: {foo(a)}")]],
    })
    assert.are.same({
      [[def foo(n):]],
      [[    if n in (1, 2, 3):]],
      [[        return n + 1]],
      [[]],
      [[]],
      [[a, b = 1, 2]],
      [[b, a = a, b]],
      [[print(f"The factorial of {a} is: {foo(a)}")]],
    }, formatted)
  end)

  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('ruff', 'py', {
      [[import os]],
      [[x = 1]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'ruff',
      code = 'F401',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('ruff', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
