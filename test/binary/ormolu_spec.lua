describe('ormolu', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('ormolu', 'hs', {
      [[module Main where]],
      [[main = putStrLn "hello"]],
    })
    assert.are.same({
      [[module Main where]],
      [[]],
      [[main = putStrLn "hello"]],
    }, formatted)
  end)
end)
