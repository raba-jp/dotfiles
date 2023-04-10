# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.50.114";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.50.114/brave-browser_1.50.114_amd64.deb";
      sha256 = "12bl0qnfgd9rgy1y0nm6xg83j8ij69fd2ac5dxa5919hxv28v6v9";
    };
  });
}
