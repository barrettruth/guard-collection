describe('shellcheck', function()
  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('shellcheck', 'sh', {
      [[#!/bin/sh]],
      [[echo $FOO]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'shellcheck',
      severity = vim.diagnostic.severity.INFO,
      message_pat = 'Double quote',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('shellcheck', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
