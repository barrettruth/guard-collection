describe('pg_format', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('pg_format', 'sql', {
      [[select id, name from users where id = 1;]],
    })
    assert.is_true(#formatted > 1)
    assert.is_truthy(formatted[1]:match('SELECT'))
  end)
end)
