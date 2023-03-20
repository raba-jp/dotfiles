# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.49.120";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.49.120/brave-browser_1.49.120_amd64.deb";
      sha256 = "09gkyfln0l8xagnflf68svcq952m7qswpljscfavnwsalcfvlar9";
    };
  });
}
