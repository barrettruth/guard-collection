describe('cpplint', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('cpp'):lint('cpplint')

    local buf, diagnostics = helper.test_with('cpp', {
      [[// Copyright 2026 Test]],
      [[int main(){int x=1;}]],
    })
    assert.are.same({
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = '[whitespace/operators] Missing spaces around =',
        namespace = ns,
        severity = 1,
        source = 'cpplint',
      },
      {
        bufnr = buf,
        col = 0,
        end_col = 0,
        end_lnum = 1,
        lnum = 1,
        message = '[whitespace/braces] Missing space before {',
        namespace = ns,
        severity = 1,
        source = 'cpplint',
      },
    }, diagnostics)
  end)
end)
