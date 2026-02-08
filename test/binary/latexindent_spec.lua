describe('latexindent', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('latexindent', 'latex', {
      [[\documentclass{article}]],
      [[\begin{document}]],
      [[Shopping list]],
      [[\begin{itemize}]],
      [[\item 1. eggs]],
      [[\item 2. butter]],
      [[\item 3. bread]],
      [[\end{itemize}]],
      [[\end{document}]],
    })
    assert.are.same({
      [[\documentclass{article}]],
      [[\begin{document}]],
      [[Shopping list]],
      [[\begin{itemize}]],
      '\t\\item 1. eggs',
      '\t\\item 2. butter',
      '\t\\item 3. bread',
      [[\end{itemize}]],
      [[\end{document}]],
    }, formatted)
  end)
end)
