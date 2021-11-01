{ inputs, config, pkgs, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = false;
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
