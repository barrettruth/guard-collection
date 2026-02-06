describe('buf', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('buf', 'proto', {
      'syntax="proto3";',
      'package test;',
      'message Foo{string bar=1;}',
    })
    assert.is_true(#formatted > 3)
  end)

  it('can lint', function()
    local linter = require('test.helper').get_linter('buf')
    local tmpdir = '/tmp/buf-lint-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({ 'version: v2' }, tmpdir .. '/buf.yaml')
    vim.fn.writefile({
      'syntax = "proto3";',
      'message Foo {',
      '  string bar = 1;',
      '}',
    }, tmpdir .. '/test.proto')
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'buf',
        'lint',
        '--error-format=json',
        tmpdir .. '/test.proto',
      })
      :wait()
    local output = result.stdout or ''
    if output == '' then
      output = result.stderr or ''
    end
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('buf', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
