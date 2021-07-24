{ config, pkgs, ... }: {
  nix = {
    package = pkgs.nixUnstable;

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
      experimental-features = nix-command flakes
    '';

    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 31d";
    };

    trustedUsers = [ "root" "sakuraba" ];
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];
}