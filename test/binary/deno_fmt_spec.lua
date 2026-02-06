describe('deno fmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('deno_fmt', 'typescript', {
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
