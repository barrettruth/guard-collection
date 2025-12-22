describe('deno fmt', function()
  it('can format', function()
    local ft = require('guard.filetype')
    ft('typescript'):fmt('deno_fmt')

    local formatted = require('test.formatter.helper').test_with('typescript', {
      [[function ]],
      [[    fibonacci(num:]],
      [[    number):]],
      [[number {]],
      [[  if ]],
      [[        (num           <= 1              ]],
      [[    )]],
      [[    return num          ;]],
      [[  return fibonacci(num - 1) + fibonacci(num - 2]],
      [[    );]],
      [[}]],
    })
    assert.are.same({
      [[function fibonacci(num: number): number {]],
      [[  if (num <= 1) {]],
      [[    return num;]],
      [[  }]],
      [[  return fibonacci(num - 1) + fibonacci(num - 2);]],
      [[}]],
    }, formatted)
  end)
end)
