describe('stylelint', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-stylelint-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      '{ "rules": { "color-no-invalid-hex": true } }',
    }, tmpdir .. '/.stylelintrc.json')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('stylelint', 'css', {
      'a { color: #fff1az; }',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'stylelint',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('stylelint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
