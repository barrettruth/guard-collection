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
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('ktlint', 'kt', {
      [[fun main() {]],
      [[    val x=1]],
      [[    println(x)]],
      [[}]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = buf,
      source = 'ktlint',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('ktlint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
