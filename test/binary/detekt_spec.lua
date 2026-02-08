describe('detekt', function()
  it('can lint', function()
    local linter = require('test.helper').get_linter('detekt')
    local tmpfile = '/tmp/guard-test.kt'
    local input = {
      [[fun main() {]],
      [[    val x = 42]],
      [[    if (x > 0) {]],
      [[        println(x)]],
      [[    }]],
      [[}]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim.system({ 'detekt', '-i', tmpfile }):wait()
    local output = result.stdout or ''
    if output == '' then
      output = result.stderr or ''
    end
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('detekt', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
