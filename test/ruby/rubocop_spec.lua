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

  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('rubocop', 'rb', {
      [[x = {  :a=>1,:b  =>  2  }]],
    }, { cwd = tmpdir })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
