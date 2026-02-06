describe('pylint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('pylint')
    local tmpfile = '/tmp/guard-test.py'
    local input = {
      [[import os]],
      [[x = 1]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'pylint',
        '--from-stdin',
        '--output-format',
        'json',
        tmpfile,
      }, {
        stdin = table.concat(input, '\n') .. '\n',
      })
      :wait()
    local output = result.stdout or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('pylint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
