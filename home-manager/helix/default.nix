{pkgs, ...}: {
  home.packages = with pkgs; [
    clojure-lsp
    solargraph
    gopls
    rust-analyzer
    rnix-lsp
    terraform-ls
    sumneko-lua-language-server
    # cuelsp
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

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        file-picker = {
          hidden = false;
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
          ";" = "command_mode";
        };
        insert = {
          "C-." = "normal_mode";
          t.n = "normal_mode";
        };
      };
    };
  };
}
