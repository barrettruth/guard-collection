describe('checkmake', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('make'):lint('checkmake')

    local buf, diagnostics = helper.test_with('make', {
      [[all:]],
      [[\techo hello]],
    })
    helper.assert_diagnostics(diagnostics, {
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '[minphony] Missing required phony target "all"',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '[minphony] Missing required phony target "clean"',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 0,
        lnum = 0,
        message = '[minphony] Missing required phony target "test"',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = '[phonydeclared] Target "all" should be declared PHONY.',
        namespace = ns,
        severity = 2,
        source = 'checkmake',
      },
    })
  end)
end)
