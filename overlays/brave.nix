
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: rec {
    version = "1.48.158";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.48.158/brave-browser_1.48.158_amd64.deb";
      sha256 = "1mlxfmlk1ahk4xgx00vg3zx2nxc7ag4zfwnr4b58v1zdr3w7q1c6";
    };
  });
}
