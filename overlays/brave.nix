final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.45.118";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "sha256-DXLAguPi3ZvkSiHA3leSpgvz6zN2tiPJCJmixqucxGo=";
    };
  });
}
