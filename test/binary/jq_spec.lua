describe('jq', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('json'):fmt('jq')

    local formatted = require('test.fmt_helper').test_with('json', {
      [[{"foo":"bar","baz":1}]],
    })
    assert.are.same({
      [[{]],
      [[  "foo": "bar",]],
      [[  "baz": 1]],
      [[}]],
    }, formatted)
  end)
end)
