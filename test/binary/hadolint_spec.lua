describe('hadolint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local linter = helper.get_linter('hadolint')
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
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'hadolint',
      severity = vim.diagnostic.severity.WARN,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('hadolint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
