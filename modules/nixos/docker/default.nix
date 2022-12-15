{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.dotfiles.docker;
in {
  options.dotfiles.docker = {
    enable = mkEnableOption "if you need docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
