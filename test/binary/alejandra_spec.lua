describe('alejandra', function()
  it('can format', function()
    local formatted = require('test.helper').run_fmt('alejandra', 'nix', {
      [[{inputs={nixpkgs.url="github:NixOS/nixpkgs/nixos-unstable";};}]],
    })
    assert.are.same({
      [[{inputs = {nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";};}]],
    }, formatted)
  end)
end)
