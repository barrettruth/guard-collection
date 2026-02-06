local M = {}
local api = vim.api

function M.run_fmt(name, ft, input, opts)
  opts = opts or {}
  local config = require('guard-collection.formatter')[name]
  assert(config, 'unknown formatter: ' .. name)
  assert(not config.fn, name .. ' uses custom fn, not testable this way')
  local cmd = vim.list_extend({ config.cmd }, config.args or {})
  local dir = opts.tmpdir or '/tmp'
  local tmpfile = dir .. '/guard-test.' .. ft
  if config.fname then
    vim.fn.writefile(input, tmpfile)
    table.insert(cmd, tmpfile)
  end
  local result = vim
    .system(cmd, {
      stdin = config.stdin and (table.concat(input, '\n') .. '\n') or nil,
      cwd = opts.cwd,
    })
    :wait()
  assert(result.code == 0, name .. ' exited ' .. result.code .. ': ' .. (result.stderr or ''))
  if config.stdin then
    return vim.split(result.stdout, '\n', { trimempty = true })
  else
    return vim.fn.readfile(tmpfile)
  end
end

function M.run_lint(name, ft, input)
  local linter = require('guard-collection.linter')[name]
  assert(linter, 'unknown linter: ' .. name)
  assert(not linter.fn, name .. ' uses custom fn — test parse() directly instead')
  local input_str = table.concat(input, '\n') .. '\n'
  local tmpfile = '/tmp/guard-test.' .. ft
  vim.fn.writefile(input, tmpfile)
  local bufnr = api.nvim_create_buf(false, true)
  local cmd = vim.list_extend({ linter.cmd }, linter.args or {})
  if linter.fname then
    table.insert(cmd, tmpfile)
  end
  local result = vim
    .system(cmd, {
      stdin = linter.stdin and input_str or nil,
    })
    :wait()
  local output = result.stdout or ''
  if output == '' then
    output = result.stderr or ''
  end
  local diags = linter.parse(output, bufnr)
  return bufnr, diags
end

function M.get_linter(name)
  local linter = require('guard-collection.linter')[name]
  assert(linter, 'unknown linter: ' .. name)
  return linter
end

return M
