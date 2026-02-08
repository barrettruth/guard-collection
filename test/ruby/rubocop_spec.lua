describe('rubocop', function()
  local tmpdir = '/tmp/rubocop-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({
      "source 'https://rubygems.org'",
      "gem 'rubocop'",
    }, tmpdir .. '/Gemfile')
    vim.system({ 'bundle', 'install' }, { cwd = tmpdir }):wait()
  end)

  it('can format', function()
    local input = {
      [[x = {  :a=>1,:b  =>  2  }]],
    }
    local result = vim
      .system({
        'bundle',
        'exec',
        'rubocop',
        '-A',
        '-f',
        'quiet',
        '--stderr',
        '--stdin',
        'test.rb',
      }, {
        stdin = table.concat(input, '\n') .. '\n',
        cwd = tmpdir,
      })
      :wait()
    local output = result.stderr or ''
    local formatted = vim.split(output, '\n', { trimempty = true })
    assert.is_true(#formatted > 0)
  end)

  it('can lint', function()
    local linter = require('test.helper').get_linter('rubocop')
    local input = {
      [[x = {  :a=>1,:b  =>  2  }]],
    }
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'bundle',
        'exec',
        'rubocop',
        '--format',
        'json',
        '--force-exclusion',
        '--stdin',
        'test.rb',
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
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
