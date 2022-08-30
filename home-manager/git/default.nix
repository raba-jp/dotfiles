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

      user = {useConfigOnly = true;};

      color = {
        status = "auto";
        diff = "auto";
        branch = "auto";
        interactive = "auto";
        grep = "auto";
      };

      pull.ff = "only";

      push.autoSetupRemote = true;
    };
  };
}
