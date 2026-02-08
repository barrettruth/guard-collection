describe('cbfmt', function()
  it('can format', function()
    local tmpdir = '/tmp/cbfmt-test'
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({ '[languages]' }, tmpdir .. '/.cbfmt.toml')
    local input = {
      '# Title',
      '',
      'Some text.',
    }
    local result = vim
      .system({ 'cbfmt', '--best-effort', '-p', 'markdown' }, {
        stdin = table.concat(input, '\n') .. '\n',
        cwd = tmpdir,
      })
      :wait()
    assert(result.code == 0, 'cbfmt exited ' .. result.code .. ': ' .. (result.stderr or ''))
    local formatted = vim.split(result.stdout, '\n', { trimempty = true })
    assert.are.same({
      '# Title',
      '',
      'Some text.',
    }, formatted)
  end)
end)
