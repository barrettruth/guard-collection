describe('sql-formatter', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('sql-formatter', 'sql', {
      [[SELECT          *]],
      [[FROM]],
      [[World]],
      [[WHERE   "Someone"]],
      [[        LIKE     '%YOU%']],
    })
    assert.are.same({
      [[SELECT]],
      [[  *]],
      [[FROM]],
      [[  World]],
      [[WHERE]],
      [[  "Someone" LIKE '%YOU%']],
    }, formatted)
  end)
end)
