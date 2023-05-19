# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.51.118";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.51.118/brave-browser_1.51.118_amd64.deb";
      sha256 = "1mvgmd3zc9vbm7r5q07gzrki8zph5l5svdm1v7cyg89shc3ygspw";
    };
  });
}
