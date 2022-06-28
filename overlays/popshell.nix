_final: prev: {
  gnomeExtensions.pop-shell = prev.gnomeExtensions.pop-shell.overrideAttrs (_old: {
    version = "latest";
    src = prev.fetchFromGitHub {
      owner = "pop-os";
      repo = "shell";
      rev = "811201b37a6dafa51539f26cf7da029d4ccdbafb";
      sha256 = "4dzck/idSE+VCMCahRKW6LJ/tF+taraT2qDk9v7vBnM=";
    };
  });
}
