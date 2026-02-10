describe('rubocop', function()
  it('can lint', function()
    local helper = require('test.helper')
    local bufnr, diagnostics = helper.run_lint('rubocop', 'rb', {
      [[x = {  :a=>1,:b  =>  2  }]],
    })
    assert.is_true(#diagnostics > 0)
    helper.assert_diag(diagnostics[1], {
      bufnr = bufnr,
    })
    for _, d in ipairs(diagnostics) do
      assert.equal(bufnr, d.bufnr)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
