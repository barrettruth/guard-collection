describe('eslint', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-eslint-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      'module.exports = [{ rules: { "no-unused-vars": "error" } }];',
    }, tmpdir .. '/eslint.config.js')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('eslint', 'js', {
      'const x = 1;',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'eslint',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('eslint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
