
# Auto generated
final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.46.134";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.46.134/brave-browser_1.46.134_amd64.deb";
      sha256 = "1qyn1rvyjd58ph5kl63wq7db7k2gf03hg09c3a4xq7wfix4qx3g6";
    };
  });
}
