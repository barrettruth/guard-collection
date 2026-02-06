describe('clang-tidy', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('clang-tidy', 'c', {
      [[#include <stdio.h>]],
      [[int main() {]],
      [[    int x = 10;]],
      [[    int y = 0;]],
      [[    printf("%d", x / y);]],
      [[    return 0;]],
      [[}]],
    })
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('clang-tidy', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
