describe('eslint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local tmpdir = '/tmp/eslint-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      'module.exports = [{ rules: { "no-unused-vars": "error" } }];',
    }, tmpdir .. '/eslint.config.js')
    local buf, diagnostics = helper.run_lint('eslint', 'js', {
      [[const x = 1;]],
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'eslint',
      severity = vim.diagnostic.severity.ERROR,
      code = 'no-unused-vars',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('eslint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
