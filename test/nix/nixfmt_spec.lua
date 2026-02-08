describe('nixfmt', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('nixfmt', 'nix', {
      [[{pkgs,...}:{environment.systemPackages=[pkgs.vim];}]],
    })
    assert.is_true(#formatted > 0)
    assert.is_true(formatted[1]:find('pkgs') ~= nil)
  end)
end)
