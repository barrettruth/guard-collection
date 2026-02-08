describe('shellcheck', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('shellcheck')
    local tmpfile = '/tmp/guard-test.sh'
    local input = {
      [[#!/bin/sh]],
      [[echo $FOO]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'shellcheck',
        '--format',
        'json1',
        '--external-sources',
        tmpfile,
      })
      :wait()
    local output = result.stdout or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('shellcheck', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
