{ ...}: {
  imports = [./aliases.nix ./ignore.nix];
  programs.git = {
    enable = true;
    delta.enable = true;

    userName = "Hiroki Sakuraba";

    extraConfig = {
      core = {
        editor = "vim";
        preloadindex = true;
        fsmonitor = "rs-git-fsmonitor";
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
    };
  };
}
