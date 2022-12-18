{
  pkgs,
  inputs,
  system,
  ...
}: {
  # LSP
  home.packages = with pkgs; [
    clojure-lsp
    solargraph
    gopls
    rust-analyzer
    terraform-ls
    sumneko-lua-language-server
    cuelsp
    nodePackages.typescript-language-server
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    jsonnet-language-server
    zls
    nil
  ];

  programs.helix = {
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.default;

    languages = [
      {
        name = "nix";
        auto-format = true;
        language-server = {
          command = "nil";
          args = [];
        };
        formatter = {
          command = "alejandra";
          args = ["--quiet" "-"];
        };
      }
    ];

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        shell = ["${pkgs.fish}/bin/fish" "-c"];
        lsp.display-messages = true;
        true-color = true;
        cursorline = true;
        color-modes = true;
        completion-trigger-len = 1;

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        statusline = {
          left = ["mode" "spinner" "diagnostics"];
          center = ["file-name"];
          right = ["selections" "position" "file-type"];
        };

        whitespace = {
          render = {
            newline = "all";
          };
        };

        indent-guides = {
          render = true;
        };
      };

      keys = {
        normal = {
        };
        insert = {
          "C-." = "normal_mode";
          j.j = "normal_mode";
        };
      };
    };
  };
}