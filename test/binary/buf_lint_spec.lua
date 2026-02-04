describe('buf', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('proto'):lint('buf')

    local buf, diagnostics = helper.test_with('proto', {
      [[invalid proto content]],
    })
    assert.are.same({
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = 'syntax error: unexpected identifier',
        namespace = ns,
        severity = 4,
        source = 'buf',
      },
    }, diagnostics)
  end)
end)
