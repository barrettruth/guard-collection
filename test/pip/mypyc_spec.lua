describe('mypyc', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('mypyc', 'py', {
      'def add(x: int, y: int) -> int:',
      '    return x + y',
      '',
      'add("hello", "world")',
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'mypy',
      severity = vim.diagnostic.severity.ERROR,
      message_pat = 'arg-type',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('mypy', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
