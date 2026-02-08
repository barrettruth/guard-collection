describe('hadolint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('hadolint')
    local tmpfile = '/tmp/guard-test.dockerfile'
    local input = {
      [[FROM ubuntu]],
      [[RUN apt-get install python]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim
      .system({
        'hadolint',
        '--no-fail',
        '--format=json',
        tmpfile,
      })
      :wait()
    local output = result.stdout or ''
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('hadolint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
