describe('stylelint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local tmpdir = '/tmp/stylelint-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      '{ "rules": { "color-no-invalid-hex": true } }',
    }, tmpdir .. '/.stylelintrc.json')
    local buf, diagnostics = helper.run_lint('stylelint', 'css', {
      [[a { color: #fff1az; }]],
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'stylelint',
      code = 'color-no-invalid-hex',
      severity = vim.diagnostic.severity.ERROR,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('stylelint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
