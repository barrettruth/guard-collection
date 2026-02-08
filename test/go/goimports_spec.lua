describe('goimports', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('goimports', 'go', {
      [[package main]],
      [[]],
      [[import "fmt"]],
      [[import "os"]],
      [[]],
      [[func main() {]],
      [[fmt.Println(os.Args)]],
      [[}]],
    })
    assert.are.same({
      [[package main]],
      [[]],
      [[import (]],
      '\t"fmt"',
      '\t"os"',
      [[)]],
      [[]],
      [[func main() {]],
      '\tfmt.Println(os.Args)',
      [[}]],
    }, formatted)
  end)
end)
