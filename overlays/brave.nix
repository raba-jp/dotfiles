
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.47.171";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.47.171/brave-browser_1.47.171_amd64.deb";
      sha256 = "13vj5scy0n7bhlh6sin84kh4gh5pxdm4c0r7ymhinzxmssrah4nj";
    };
  });
}
