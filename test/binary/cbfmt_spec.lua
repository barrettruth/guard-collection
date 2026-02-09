describe('cbfmt', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-cbfmt-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({ '[languages]' }, tmpdir .. '/.cbfmt.toml')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

  it('can format', function()
    local formatted = require('test.helper').run_fmt('cbfmt', 'md', {
      '# Title',
      '',
      'Some text.',
    }, { cwd = tmpdir })
    assert.are.same({
      '# Title',
      '',
      'Some text.',
    }, formatted)
  end)
end)
