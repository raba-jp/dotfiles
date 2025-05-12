{...}: {
  homebrew = {
    enable = true;

    onActivation.autoUpdate = true;

    brews = [];

    taps = [
      "homebrew/bundle"
      "homebrew/services"
    ];

    casks = [
      "appcleaner"
      "akiflow"
      "discord"
      "ghostty"
      "the-unarchiver"
      "cursor"
      "visual-studio-code"
      "windsurf"
      "raycast"
      "qlmarkdown"
      "readdle-spark"
      "font-udev-gothic"
      "font-udev-gothic-nf"
      "font-moralerspace"
      "font-moralerspace-nf"
      "font-moralerspace-hw"
      "font-moralerspace-hw-nf"
      "font-moralerspace-hw-jpdoc"
      "font-moralerspace-jpdoc"
    ];

    masApps = {
    };
  };
}
