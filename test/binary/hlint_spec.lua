describe('hlint', function()
  it('can lint', function()
    local helper = require('test.helper')
    local buf, diagnostics = helper.run_lint('hlint', 'haskell', {
      [[concat $ map escapeC s]],
      [[ftable ++ (map (\ (c, x) -> (toUpper c, urlEncode x)) ftable)]],
      [[mapM (delete_line (fn2fp f) line) old]],
    })
    assert.is_true(#diagnostics > 0)
    for _, d in ipairs(diagnostics) do
      assert.equal(buf, d.bufnr)
      assert.equal('hlint', d.source)
      assert.is_number(d.lnum)
      assert.is_string(d.message)
    end
  end)
end)
