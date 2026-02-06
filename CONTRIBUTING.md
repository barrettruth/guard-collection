# Contributing to guard-collection

- Add your config to `formatter.lua` or `linter/<tool-name>.lua`, if it's a linter don't forget to export it in `linter/init.lua`
- Write a test in the appropriate `test/<category>/` directory. Tests run tools synchronously via `vim.system():wait()`, bypassing guard.nvim's async pipeline.

Formatter example:

```lua
describe('black', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('black', 'python', {
      [[def foo(n):]],
      [[    if n in         (1,2,3):]],
      [[        return n+1]],
    })
    assert.are.same({
      [[def foo(n):]],
      [[    if n in (1, 2, 3):]],
      [[        return n + 1]],
    }, formatted)
  end)
end)
```

Linter example:

```lua
describe('flake8', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('flake8', 'python', {
      [[import os]],
    })
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('flake8', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
```

For linters with a custom `fn` (cpplint, checkmake, zsh), run the command directly and test `parse()`:

```lua
describe('cpplint', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('cpplint')
    local tmpfile = '/tmp/guard-test.cpp'
    vim.fn.writefile({ [[int main(){int x=1;}]] }, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim.system({ 'cpplint', '--filter=-legal/copyright', tmpfile }, {}):wait()
    local diagnostics = linter.parse(result.stderr or '', bufnr)
    assert.is_true(#diagnostics > 0)
  end)
end)
```

- Add your tool to CI in `.github/workflows/ci.yaml` under the appropriate job
- Run the test locally:
  ```shell
  # requires: neovim, lua 5.1, luarocks, busted, nlua
  # also requires guard.nvim cloned: git clone --depth 1 https://github.com/nvimdev/guard.nvim && mv guard.nvim/lua/guard lua/
  make test-pip  # or whichever category
  ```
- Format with stylua before submitting:
  ```shell
  stylua .
  ```
- Add the tool to the README list and you are good to go!
