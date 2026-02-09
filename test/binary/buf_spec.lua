describe('buf', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-buf-test'

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
    }, { tmpdir = tmpdir })
    assert.is_true(#formatted > 3)
  end)

  it('can lint', function()
    local helper = require('test.helper')
    vim.fn.writefile({ 'version: v2' }, tmpdir .. '/buf.yaml')
    local buf, diagnostics = helper.run_lint('buf', 'proto', {
      'syntax = "proto3";',
      'message Foo {',
      '  string bar = 1;',
      '}',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'buf',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('buf', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
