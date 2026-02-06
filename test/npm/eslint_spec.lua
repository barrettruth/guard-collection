describe('eslint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('eslint')
    local tmpdir = '/tmp/eslint-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      'module.exports = [{ rules: { "no-unused-vars": "error" } }];',
    }, tmpdir .. '/eslint.config.js')
    local tmpfile = tmpdir .. '/test.js'
    local input = {
      [[const x = 1;]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'npx',
        'eslint',
        '--format',
        'json',
        '--stdin',
        '--stdin-filename',
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
      assert.equal('eslint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
