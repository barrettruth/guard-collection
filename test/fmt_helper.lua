local M = {}
local api = vim.api

function M.test_with(ft, input)
  local cmd = require('guard.filetype')(ft).formatter[1].cmd
  assert(not cmd or vim.fn.executable(cmd) == 1)
  local bufnr = api.nvim_create_buf(true, false)
  vim.bo[bufnr].filetype = ft
  api.nvim_set_current_buf(bufnr)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, input)
  vim.fn.mkdir('/tmp/guard-test', 'p')
  vim.cmd('silent! write! /tmp/guard-test/file.' .. ft)
  require('guard.format').do_fmt(bufnr)
  vim.wait(3000)
  return api.nvim_buf_get_lines(bufnr, 0, -1, false)
end

return M
