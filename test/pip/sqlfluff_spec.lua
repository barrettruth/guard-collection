describe('sqlfluff', function()
  local tmpdir = vim.fn.getcwd() .. '/tmp-sqlfluff-test'

  setup(function()
    vim.fn.mkdir(tmpdir, 'p')
    vim.fn.writefile({ '[sqlfluff]', 'dialect = ansi' }, tmpdir .. '/.sqlfluff')
  end)

  teardown(function()
    vim.fn.delete(tmpdir, 'rf')
  end)

  it('can format', function()
    local formatted = require('test.helper').run_fmt('sqlfluff', 'sql', {
      [[SELECT          *]],
      [[FROM]],
      [[         World         ]],
      [[WHERE   "Someone"]],
      [[        LIKE     '%YOU%']],
    }, { cwd = tmpdir })
    assert.are.same({
      [[SELECT *]],
      [[FROM]],
      [[    World]],
      [[WHERE]],
      [[    "Someone"]],
      [[    LIKE '%YOU%']],
    }, formatted)
  end)

  it('can fix', function()
    local formatted = require('test.helper').run_fmt('sqlfluff_fix', 'sql', {
      [[SELECT]],
      [[    a + b  AS foo,]],
      [[    c AS bar]],
      [[FROM my_table]],
    }, { cwd = tmpdir })
    assert.are.same({
      [[SELECT]],
      [[    c AS bar,]],
      [[    a + b AS foo]],
      [[FROM my_table]],
    }, formatted)
  end)
end)
