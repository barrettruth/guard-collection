describe('detekt', function()
  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('detekt', 'kt', {
      [[fun main() {]],
      [[    val x = 42]],
      [[    if (x > 0) {]],
      [[        println(x)]],
      [[    }]],
      [[}]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
      source = 'detekt',
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.equal('detekt', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
