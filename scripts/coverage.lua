local skip = {
  'lsp',
  'prettierd',
  'mypyc',
  'dmypy',
  'npm_groovy_lint',
  'npm_groovy_lint_fix',
}

local formatters = require('guard-collection.formatter')
local linters = require('guard-collection.linter')

local all_tools = {}
for name in pairs(formatters) do
  if not vim.tbl_contains(skip, name) then
    all_tools[name] = 'formatter'
  end
end
for name in pairs(linters) do
  if not vim.tbl_contains(skip, name) then
    all_tools[name] = all_tools[name] and 'formatter+linter' or 'linter'
  end
end

local test_files = vim.fn.glob('test/**/*_spec.lua', false, true)
local covered = {}
for _, file in ipairs(test_files) do
  local content = table.concat(vim.fn.readfile(file), '\n')
  for name in pairs(all_tools) do
    local escaped = vim.pesc(name)
    local alt = escaped:gsub('_', '[ _]')
    -- match 'name' in string literals (describe/run_fmt) or .name table access (require().tool)
    if content:find('[\'"]' .. alt .. '[\'"]') or content:find('%.' .. escaped .. '[^%w_]') then
      covered[name] = true
    end
  end
end

local missing = {}
for name in pairs(all_tools) do
  if not covered[name] then
    table.insert(missing, name)
  end
end
table.sort(missing)

local total = vim.tbl_count(all_tools)
local skipped = #skip
local covered_count = vim.tbl_count(covered)
local missing_count = #missing

print(
  string.format(
    'Tools: %d total, %d skipped, %d covered, %d missing',
    total,
    skipped,
    covered_count,
    missing_count
  )
)

if missing_count > 0 then
  print('\nMissing tests:')
  for _, name in ipairs(missing) do
    print(string.format('  %s (%s)', name, all_tools[name]))
  end
  os.exit(1)
end

print('All testable tools have coverage.')
