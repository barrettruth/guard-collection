local lint = require('guard.lint')

return {
  fn = function(_, fname)
    local co = assert(coroutine.running())
    vim.system({ 'cpplint', '--filter=-legal/copyright', fname }, {}, function(result)
      coroutine.resume(co, result.stderr or '')
    end)
    return coroutine.yield()
  end,
  parse = function(result, bufnr)
    local diags = {}
    for line in result:gmatch('[^\n]+') do
      local lnum, msg, cat, sev = line:match('^[^:]+:(%d+):%s*(.-)%s+%[([^%]]+)%]%s+%[(%d+)%]$')
      if lnum then
        local severity = tonumber(sev) >= 3 and vim.diagnostic.severity.ERROR
          or vim.diagnostic.severity.WARN
        table.insert(
          diags,
          lint.diag_fmt(
            bufnr,
            tonumber(lnum) - 1,
            0,
            ('[%s] %s'):format(cat, msg),
            severity,
            'cpplint'
          )
        )
      end
    end
    return diags
  end,
}
