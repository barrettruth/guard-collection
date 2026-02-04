describe('clang-tidy', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
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
    assert.is_true(#diagnostics > 0)
    assert.are.equal('clang-tidy', diagnostics[1].source)
  end)
end)
