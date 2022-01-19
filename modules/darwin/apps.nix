{ inputs, config, pkgs, ... }: {
  homebrew = {
    casks = [
      "alacritty"
      "alfred"
      "appcleaner"
      "bartender"
      "betterdummy"
      "bettertouchtool"
      "bitwarden"
      "clipy"
      "deepl"
      "discord"
      "font-hackgen"
      "font-myrica"
      # "google-chrome"
      "hammerspoon"
      "hyperswitch"
      "kitty"
      "obsidian"
      "qlmarkdown"
      "quicklook-csv"
      # "slack"
      "stack-stack"
      "tableplus"
      "the-unarchiver"
      "visual-studio-code"
      "zoom"
    ];
  };
}
