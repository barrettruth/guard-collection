describe('ktlint', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('ktlint', 'kt', {
      [[fun main() {]],
      [[    val x=1]],
      [[    println(x)]],
      [[}]],
    })
    assert.are.same({
      [[fun main() {]],
      [[    val x = 1]],
      [[    println(x)]],
      [[}]],
    }, formatted)
  end)

  it('can lint', function()
    local linter = require('test.helper').get_linter('ktlint')
    local tmpfile = '/tmp/guard-test.kt'
    local input = {
      [[fun main() {]],
      [[    val x=1]],
      [[    println(x)]],
      [[}]],
    }
    vim.fn.writefile(input, tmpfile)
    local bufnr = vim.api.nvim_create_buf(false, true)
    local result = vim.system({ 'ktlint', '--log-level=error', tmpfile }):wait()
    local output = result.stdout or ''
    if output == '' then
      output = result.stderr or ''
    end
    local diagnostics = linter.parse(output, bufnr)
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('ktlint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
