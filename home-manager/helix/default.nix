{pkgs, ...}: {
  home.packages = with pkgs; [
    clojure-lsp
    solargraph
    gopls
    rust-analyzer
    rnix-lsp
    terraform-ls
    sumneko-lua-language-server
    cuelsp
    nodePackages.typescript-language-server
  ];
  programs.helix = {
    enable = true;
    package = pkgs.helix-latest;

    languages = [
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "alejandra";
          args = ["--quiet" "-"];
        };
      }
    ];

    settings = {
      theme = "nord";

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
          n = "move_line_down"; # swap j
          t = "move_line_up"; # swap l
          b = "move_char_left";
          r = "move_char_right";
          l = "find_till_char"; # swap t
          L = "till_prev_char";
          j = "search_next"; # swap n
          J = "search_prev";
          h = "no_op";
          k = "no_op";
          g.b = "goto_line_start";
          g.r = "goto_line_end";
          g.h = "no_op";
          g.l = "no_op";
        };
        insert = {
          "C-." = "normal_mode";
          j.j = "normal_mode";
        };
      };
    };
  };
}
