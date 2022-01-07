{ inputs, config, pkgs, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = false;
    # FIX: https://github.com/LnL7/nix-darwin/pull/418/files
    brewPrefix = if pkgs.stdenv.hostPlatform.darwinArch == "aarch64" then "/opt/homebrew/bin" else "/usr/local/bin";
    global = {
      brewfile = true;
      noLock = true;
    };

    taps = [
      "bufbuild/buf"
      "buildpacks/tap"
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
      "homebrew/services"
      "reviewdog/tap"
      "tilt-dev/tap"
    ];
  };
}
