describe('buf', function()
  local tmpdir = '/tmp/buf-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

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
    vim.fn.writefile({ 'version: v2' }, tmpdir .. '/buf.yaml')
    local protofile = tmpdir .. '/test.proto'
    vim.fn.writefile({
      'syntax = "proto3";',
      'message Foo {',
      '  string bar = 1;',
      '}',
    }, protofile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'buf',
        'lint',
        '--error-format=json',
        protofile,
      }, { cwd = tmpdir })
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
