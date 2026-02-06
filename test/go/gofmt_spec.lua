describe('gofmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('gofmt', 'go', {
      [[package         main]],
      [[]],
      [[     import   "fmt"     ]],
      [[]],
      [[func    main() {]],
      [[   x:=     1;]],
      [[          fmt.Println(x);]],
      [[}]],
    })
    assert.are.same({
      [[package main]],
      [[]],
      [[import "fmt"]],
      [[]],
      [[func main() {]],
      [[	x := 1]],
      [[	fmt.Println(x)]],
      [[}]],
    }, formatted)
  end)
end)
