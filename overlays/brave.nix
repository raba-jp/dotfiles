# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.56.9";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.56.9/brave-browser_1.56.9_amd64.deb";
      sha256 = "1ydv3l6gv24m2i9hy66dz7v4jzcxzl98dn8ixg61yq5h8z2ka3kk";
    };
  });
}
