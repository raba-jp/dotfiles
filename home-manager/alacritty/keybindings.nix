{ pkgs, ... }: {
  programs.alacritty.settings.key_bindings = [
    {
      key = "Q";
      mods = "Control";
      chars = "\\x11";
    }
    {
      key = "Minus";
      mods = "Control";
      action = "DecreaseFontSize";
    }
    {
      key = "Equals";
      mods = "Control";
      action = "IncreaseFontSize";
    }
    # Linux only
    {
      key = "V";
      mods = "Control|Shift";
      action = "Paste";
    }
    {
      key = "C";
      mods = "Control|Shift";
      action = "Copy";
    }
    # macOS only
    {
      key = "V";
      mods = "Command";
      action = "Paste";
    }
    {
      key = "C";
      mods = "Command";
      action = "Copy";
    }
  ];
}
