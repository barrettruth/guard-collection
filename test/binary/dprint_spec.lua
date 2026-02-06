describe('dprint', function()
  it('can format', function()
    local tmpdir = '/tmp/dprint-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      '{',
      '  "typescript": {}',
      '}',
    }, tmpdir .. '/dprint.json')
    local input = {
      [[const x=1;]],
      [[function foo(  ){return x}]],
    }
    local result = vim
      .system({ 'dprint', 'fmt', '--stdin', 'test.ts' }, {
        stdin = table.concat(input, '\n') .. '\n',
        cwd = tmpdir,
      })
      :wait()
    assert(result.code == 0, 'dprint exited ' .. result.code .. ': ' .. (result.stderr or ''))
    local formatted = vim.split(result.stdout, '\n', { trimempty = true })
    assert.is_true(#formatted > 0)
    assert.is_true(formatted[1]:find('const x') ~= nil)
  end)
end)
