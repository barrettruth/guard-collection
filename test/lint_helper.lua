local M = {}
local api = vim.api
local lint = require('guard.lint')
M.namespace = api.nvim_get_namespaces().Guard

function M.test_with(ft, input)
  local linter = require('guard.filetype')(ft).linter[1]
  local cmd = linter.cmd
  if cmd then
    assert(vim.fn.executable(cmd) == 1)
  end

  local bufnr = api.nvim_create_buf(true, false)
  vim.bo[bufnr].filetype = ft
  api.nvim_set_current_buf(bufnr)
  api.nvim_buf_set_lines(bufnr, 0, -1, false, input)
  vim.fn.mkdir('/tmp/guard-test', 'p')
  vim.cmd('silent! write! /tmp/guard-test/test.' .. ft)

  lint.do_lint(bufnr)
  vim.wait(3000)
  local diagnostics = vim.diagnostic.get(bufnr)
  for _, d in ipairs(diagnostics) do
    d._extmark_id = nil
  end
  return bufnr, diagnostics
end

return M
