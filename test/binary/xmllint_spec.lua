describe('xmllint', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('xmllint', 'xml', {
      [[<root><child attr="val">text</child></root>]],
    })
    assert.are.same({
      [[<?xml version="1.0"?>]],
      [[<root>]],
      [[  <child attr="val">text</child>]],
      [[</root>]],
    }, formatted)
  end)
end)
