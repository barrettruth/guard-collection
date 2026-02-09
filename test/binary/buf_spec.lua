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
end)
