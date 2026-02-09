describe('ktlint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('ktlint', 'kt', {
      'fun main() {',
      '    val x=1',
      '    println(x)',
      '}',
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'ktlint',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('ktlint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
