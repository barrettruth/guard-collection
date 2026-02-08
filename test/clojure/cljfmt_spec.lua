describe('cljfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('cljfmt', 'clj', {
      [[(defn hello]],
      [[  [name]  (println "hello"]],
      [[name))]],
    })
    assert.is_true(#formatted > 0)
    assert.is_true(formatted[1]:find('defn hello') ~= nil)
  end)
end)
