describe('zsh', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('zsh'):lint('zsh')

    local buf, diagnostics = helper.test_with('zsh', {
      'if true; then',
    })
    assert.are.same({
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = "parse error near `\\n'",
        namespace = ns,
        severity = 1,
        source = 'zsh',
      },
    }, diagnostics)
  end)
end)
