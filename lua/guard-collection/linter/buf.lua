local lint = require('guard.lint')

return {
  fn = function(_, fname)
    local co = assert(coroutine.running())
    vim.system({
      'buf',
      'lint',
      '--error-format=json',
      fname .. '#format=protofile',
    }, {}, function(result)
      coroutine.resume(co, result.stdout or '')
    end)
    return coroutine.yield()
  end,
  parse = lint.from_json({
    lines = true,
    attributes = {
      lnum = 'start_line',
      col = 'start_column',
      end_lnum = 'end_line',
      end_col = 'end_column',
      code = 'type',
      message = 'message',
    },
    source = 'buf',
  }),
}
