describe('shellcheck', function()
  it('can lint', function()
    local helper = require('test.lint_helper')
    local ns = helper.namespace
    local ft = require('guard.filetype')
    ft('sh'):lint('shellcheck')

    local buf, diagnostics = helper.test_with('sh', {
      [[#!/bin/bash]],
      [[echo $foo]],
    })
    assert.is_true(#diagnostics > 0)
    assert.are.equal('shellcheck', diagnostics[1].source)
  end)
end)
