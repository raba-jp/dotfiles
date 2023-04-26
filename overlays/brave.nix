# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.50.121";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.50.121/brave-browser_1.50.121_amd64.deb";
      sha256 = "0qdmxbdzyvv9zmkdxiayx4cfx26lgd8dflwjaqybnh22s08dqpmi";
    };
  });
}
