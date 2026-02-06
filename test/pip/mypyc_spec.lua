describe('mypyc', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('mypyc')
    local tmpfile = '/tmp/guard-test.py'
    local input = {
      'def add(x: int, y: int) -> int:',
      '    return x + y',
      '',
      'add("hello", "world")',
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local cmd = vim.list_extend({ linter.cmd }, linter.args or {})
    table.insert(cmd, tmpfile)
    local result = vim.system(cmd):wait()
    local output = result.stdout or ''
    if output == '' then
      output = result.stderr or ''
    end
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('mypy', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
