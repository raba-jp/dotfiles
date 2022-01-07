# Ref: https://github.com/NixOS/nixpkgs/pull/153450
# Ref: https://github.com/NixOS/nixpkgs/pull/137512
final: prev:
let
lib = prev.lib;
stdenv= prev.stdenv;
in
{
kitty = prev.kitty.overrideAttrs (old: {

preBuild = lib.optionalString (lib.versionAtLeast stdenv.hostPlatform.darwinMinVersion "11" && stdenv.isDarwin) ''
    MACOSX_DEPLOYMENT_TARGET=10.16
'';
});
}
