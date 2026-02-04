describe('shfmt', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('sh'):fmt('shfmt')

    local formatted = require('test.fmt_helper').test_with('sh', {
      [[if [ $x = 1 ];then]],
      [[echo hello]],
      [[fi]],
    })
    assert.are.same({
      [[if [ $x = 1 ]; then]],
      [[	echo hello]],
      [[fi]],
    }, formatted)
  end)
end)
