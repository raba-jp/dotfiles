{pkgs, ...}: {
  imports = [./aliases.nix ./ignore.nix];
  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "Hiroki Sakuraba";

    extraConfig = {
      core = {
        editor = "hx";
        fsmonitor = "${pkgs.rs-git-fsmonitor}/bin/rs-git-fsmonitor";

        multipackindex = true;
        preloadindex = true;
        untrackedcache = true;
      };

      gc.auto = 0;
      gui.gcwarning = false;
      index.threads = true;
      index.version = 4;
      merge.stat = false;
      merge.renames = true;
      pack.usebitmaps = false;
      pack.usesparse = true;
      receive.autogc = false;
      feature.manyfiles = false;
      feature.experimental = false;
      fetch.unpacklimit = 1;
      fetch.writecommitgraph = false;
      fetch.showforcedupdates = false;
      status.aheadbehind = false;
      commitgraph.generationversion = 1;
      log.excludedecoration = "refs/prefetch/*";
      maintenance.auto = false;
      maintenance.strategy = incremental;

      add.interactive.useBuiltin = false;
      delta = {
        navigate = true;
        light = false;
        side-by-side = true;
        line-numbers = true;
      };
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";

      user.useConfigOnly = true;

      color = {
        status = "auto";
        diff = "auto";
        branch = "auto";
        interactive = "auto";
        grep = "auto";
      };

      pull.ff = "only";

      push.autoSetupRemote = true;

      # https://github.com/NixOS/nixpkgs/pull/193454
      # user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHrmIHH+Jzr3fj6KorpZoV9XfOGE2T557Ti4R5/Ax92T";
      # gpg.format = "ssh";
      # "gpg \"ssh\"".program =
      #   if pkgs.stdenvNoCC.isDarwin
      #   then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
      #   else "/run/current-system/sw/share/1password/op-ssh-sign";
      # commit.gpgsign = true;
    };
  };
}
