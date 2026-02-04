describe('clang-tidy', function()
  it('can lint', function()
    local helper = require('test.linter.helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('c'):lint('clang-tidy')

    local buf, diagnostics = helper.test_with('c', {
      [[#include <stdio.h>]],
      [[int main() {]],
      [[    int x = 10;]],
      [[    int y = 0;]],
      [[    printf("%d", x / y);]],
      [[    return 0;]],
      [[}]],
    })
    assert.are.same({
      {
        bufnr = buf,
        code = 'clang-analyzer-core.DivideZero',
        col = 19,
        end_col = 4,
        end_lnum = 4,
        lnum = 4,
        message = 'Division by zero',
        namespace = ns,
        severity = 2,
        source = 'clang-tidy',
      },
      {
        bufnr = buf,
        code = 'clang-analyzer-core.DivideZero',
        col = 19,
        end_col = 4,
        end_lnum = 4,
        lnum = 4,
        message = 'Division by zero',
        namespace = ns,
        severity = 2,
        source = 'clang-tidy',
      },
    }, diagnostics)
  end)
end)
