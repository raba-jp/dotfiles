final: prev: {
  gnomeExtensions.pop-shell = prev.gnomeExtensions.pop-shell.overrideAttrs (old: {
    version = "latest";
    src = prev.fetchFromGitHub {
      owner = "pop-os";
      repo = "shell";
      rev = "c10126448b495326161c3ed4bbee91485ab85179";
      sha256 = "4dzck/idSE+VCMCahRKW6LJ/tF+taraT2qDk9v7vBnM=";
    };
  });
}
