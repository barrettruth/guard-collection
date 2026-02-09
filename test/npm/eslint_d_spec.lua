describe('eslint_d', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-eslint-d-test'

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
    local bufnr, diagnostics = helper.run_lint('eslint_d', 'js', {
      'const x = 1;',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'eslint_d',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('eslint_d', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)

  it('can format', function()
    vim.fn.writefile({
      'module.exports = [{ rules: { "semi": ["error", "always"] } }];',
    }, tmpdir .. '/eslint.config.js')
    local formatted = require('test.helper').run_fmt('eslint_d', 'js', {
      'const x = 1',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.are.same({ 'const x = 1;' }, formatted)
  end)
end)
