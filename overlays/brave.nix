# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.52.122";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.52.122/brave-browser_1.52.122_amd64.deb";
      sha256 = "0p2585samsvv8s6lh8p7jsajxcdskihryrxsjck5dgy8qxpg0zsd";
    };
  });
}
