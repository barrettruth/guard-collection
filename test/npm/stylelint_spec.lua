describe('stylelint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('stylelint')
    local tmpdir = '/tmp/stylelint-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      '{ "rules": { "color-no-invalid-hex": true } }',
    }, tmpdir .. '/.stylelintrc.json')
    local tmpfile = tmpdir .. '/test.css'
    local input = {
      [[a { color: #fff1az; }]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'npx',
        'stylelint',
        '--formatter',
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
      assert.equal('stylelint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
