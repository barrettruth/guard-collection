describe('eslint_d', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('eslint_d')
    local tmpdir = '/tmp/eslintd-test'
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
        'eslint_d',
        '--format',
        'json',
        '--stdin',
        '--stdin-filename',
        tmpfile,
      }, {
        stdin = table.concat(input, '\n') .. '\n',
        cwd = tmpdir,
      })
      :wait()
    local output = result.stdout or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('eslint_d', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)

  it('can format', function()
    local tmpdir = '/tmp/eslintd-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      'module.exports = [{ rules: { "semi": ["error", "always"] } }];',
    }, tmpdir .. '/eslint.config.js')
    local tmpfile = tmpdir .. '/test.js'
    local input = {
      [[const x = 1]],
    }
    vim.fn.writefile(input, tmpfile)
    local config = require('guard-collection.formatter').eslint_d
    local cmd = vim.list_extend({ config.cmd }, config.args)
    table.insert(cmd, tmpfile)
    local result = vim
      .system(cmd, {
        stdin = table.concat(input, '\n') .. '\n',
        cwd = tmpdir,
      })
      :wait()
    assert(result.code == 0, 'eslint_d exited ' .. result.code .. ': ' .. (result.stderr or ''))
    local formatted = vim.split(result.stdout, '\n', { trimempty = true })
    assert.are.same({
      [[const x = 1;]],
    }, formatted)
  end)
end)
