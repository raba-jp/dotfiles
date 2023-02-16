
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: rec {
    version = "1.48.164";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.48.164/brave-browser_1.48.164_amd64.deb";
      sha256 = "1kgxdkg0hw7lb664fqb3ry0mqzmy2b54w12kj5plwvk13lrv36k9";
    };
  });
}
