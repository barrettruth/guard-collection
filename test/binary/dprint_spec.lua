describe('dprint', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-dprint-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      '{',
      '  "typescript": {},',
      '  "plugins": [',
      '    "https://plugins.dprint.dev/typescript-0.93.3.wasm"',
      '  ]',
      '}',
    }, tmpdir .. '/dprint.json')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

  it('can format', function()
    local formatted = require('test.helper').run_fmt('dprint', 'ts', {
      'const x=1;',
      'function foo(  ){return x}',
    }, { cwd = tmpdir, tmpdir = tmpdir })
    assert.is_true(#formatted > 0)
    assert.is_truthy(formatted[1]:find('const x'))
  end)
end)
