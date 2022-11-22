final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.45.127";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "0xm2f5rq7a6s18754x7b2qsnp7wpp3l9ip1z8brfm8klp3lp287w";
    };
  });
}
