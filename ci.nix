let
  flake = (import ./flake-compat.nix).defaultNix;
in
{
  deploy = flake.deploy;
}
