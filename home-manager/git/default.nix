{pkgs, ...}: {
  imports = [./aliases.nix ./ignore.nix];
  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "Hiroki Sakuraba";

    extraConfig = {
      core = {
        editor = "hx";
        preloadindex = true;
        fsmonitor = "${pkgs.rs-git-fsmonitor}/bin/rs-git-fsmonitor";
      };

      user = {
        useConfigOnly = true;

        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHrmIHH+Jzr3fj6KorpZoV9XfOGE2T557Ti4R5/Ax92T";
      };

      color = {
        status = "auto";
        diff = "auto";
        branch = "auto";
        interactive = "auto";
        grep = "auto";
      };

      pull.ff = "only";

      push.autoSetupRemote = true;

      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      commit.gpgsign = true;
    };
  };
}
