local lint = require('guard.lint')

return {
  fn = function(_, fname)
    local co = assert(coroutine.running())
    vim.system({ 'zsh', '-n', fname }, {}, function(result)
      coroutine.resume(co, result.stderr or '')
    end)
    return coroutine.yield()
  end,
  parse = function(result, bufnr)
    local diags = {}
    for line in result:gmatch('[^\n]+') do
      local lnum, msg = line:match(':(%d+): (.+)$')
      if lnum then
        table.insert(
          diags,
          lint.diag_fmt(bufnr, tonumber(lnum) - 1, 0, msg, vim.diagnostic.severity.ERROR, 'zsh')
        )
      end
    end
    return diags
  end,
}
