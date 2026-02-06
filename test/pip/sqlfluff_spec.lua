describe('sqlfluff', function()
  it('can format', function()
    local config = require('guard-collection.formatter').sqlfluff
    local cmd = vim.list_extend({ config.cmd }, config.args)
    vim.list_extend(cmd, { '--dialect', 'ansi' })
    local input = {
      [[SELECT          *]],
      [[FROM]],
      [[         World         ]],
      [[WHERE   "Someone"]],
      [[        LIKE     '%YOU%']],
    }
    local result = vim
      .system(cmd, {
        stdin = table.concat(input, '\n') .. '\n',
      })
      :wait()
    assert(result.code == 0, 'sqlfluff exited ' .. result.code .. ': ' .. (result.stderr or ''))
    local formatted = vim.split(result.stdout, '\n', { trimempty = true })
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
    local config = require('guard-collection.formatter').sqlfluff_fix
    local cmd = vim.list_extend({ config.cmd }, config.args)
    vim.list_extend(cmd, { '--dialect', 'ansi' })
    local input = {
      [[SELECT]],
      [[    a + b  AS foo,]],
      [[    c AS bar]],
      [[FROM my_table]],
    }
    local result = vim
      .system(cmd, {
        stdin = table.concat(input, '\n') .. '\n',
      })
      :wait()
    assert(result.code == 0, 'sqlfluff_fix exited ' .. result.code .. ': ' .. (result.stderr or ''))
    local formatted = vim.split(result.stdout, '\n', { trimempty = true })
    assert.are.same({
      [[SELECT]],
      [[    c AS bar,]],
      [[    a + b AS foo]],
      [[FROM my_table]],
    }, formatted)
  end)
end)
