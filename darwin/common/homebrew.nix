{...}: {
  homebrew = {
    enable = true;
    brews = [
    ];

    taps = [
      "homebrew/bundle"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
      "espanso/espanso"
    ];

    casks = [
      "appcleaner"
      "arc"
      "bartender"
      "discord"
      "espanso"
      "gitkraken"
      "hammerspoon"
      "the-unarchiver"
      "visual-studio-code"
      "raycast"
      "wezterm@nightly"
      "zoom"
      "macfuse"
      "obsidian"
      "qlmarkdown"
      "font-udev-gothic"
      "font-udev-gothic-nf"
    ];
  };
}
