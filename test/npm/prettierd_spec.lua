describe('prettierd', function()
  it('can format', function()
    local tmpfile = '/tmp/guard-test.js'
    local input = {
      'const x={a:1,b:2,c:3}',
      'const y = [1,2,3,4,5]',
    }
    vim.fn.writefile(input, tmpfile)
    local result = vim
      .system({ 'prettierd', tmpfile }, { stdin = table.concat(input, '\n') })
      :wait()
    assert.equal(0, result.code)
    local expected = table.concat({
      'const x = { a: 1, b: 2, c: 3 };',
      'const y = [1, 2, 3, 4, 5];',
      '',
    }, '\n')
    assert.equal(expected, result.stdout)
  end)
end)
