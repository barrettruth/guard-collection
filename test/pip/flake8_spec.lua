describe('flake8', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('flake8', 'python', {
      [[import os]],
      [[]],
      [[def foo(n):]],
      [[    if n == 0:]],
      [[         return  bar]],
      [[print("it's too long sentence to be displayed in one line, blah blah blah blah")]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'flake8',
      severity = vim.diagnostic.severity.INFO,
      code = '401',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('flake8', d.source)
      assert.is_number(d.lnum)
      assert.is_number(d.col)
      assert.is_string(d.message)
    end
  end)
end)
