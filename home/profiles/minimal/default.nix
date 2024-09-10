{
  pkgs,
  inputs,
  ...
}: {
  home = {
    sessionVariables = {
      PAGER = "bat";
    };

    packages = with pkgs; [
      ripgrep
      gh
    ];
  };

  programs.eza.enable = true;
  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.bat = {
    enable = true;
    config.style = "changes,header";
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = ["--preview 'exa --tree {} | head -200'"];
    defaultCommand = "fd --type f";
    fileWidgetOptions = [
      "--preview 'bat  --color=always --style=header,grid --line-range=:300 {}'"
    ];
    colors = {
      "bg" = "#1e1e2e";
      "bg+" = "#313244";
      "spinner" = "#f5e0dc";
      "hl" = "#f38ba8";
      "fg" = "#cdd6f4";
      "header" = "#f38ba8";
      "info" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#f5e0dc";
      "fg+" = "#cdd6f4";
      "prompt" = "#cba6f7";
      "hl+" = "#f38ba8";
    };
  };

  xdg.configFile = {
    "fish/themes/Rosé Pine Moon.theme" = {
      text = builtins.readFile (inputs.rose-pine-fish + "/themes/Rosé Pine Moon.theme");
      onChange = "${pkgs.fish}/bin/fish -c 'yes | fish_config theme save \"Rosé Pine Moon\"'";
    };
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      bind \ck up-or-search
      bind \cj down-or-search
      bind \ch backward-char
      bind \cl forward-char
      bind \cs beginning-of-line
      bind \ce end-of-line

      if test -e /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';

    # https://github.com/LnL7/nix-darwin/issues/122
    loginShellInit = ''
      fish_add_path --move --prepend --path $HOME/.nix-profile/bin /run/wrappers/bin /etc/profiles/per-user/$USER/bin /run/current-system/sw/bin

      set -U FZF_LEGACY_KEYBINDINGS 0
      set -U FZF_DISABLE_KEYBINDINGS 1
    '';

    shellAliases = {
      ls = "eza";
      ll = "eza --all --long --grid --header --no-filesize --no-time --no-user --git --icons";
      tree = "eza --tree --icons --all --git-ignore --ignore-glob=.git";
      cat = "bat";
    };

    shellAbbrs = {
      grep = "rg";
      untar = "tar -xvf";
      man = "batman";
    };

    plugins = [
      {
        name = "done";
        src = inputs.fish-done;
      }
      {
        name = "fish-ghq";
        src = inputs.fish-ghq;
      }
      {
        name = "fish-fzf";
        src = inputs.fish-fzf;
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
