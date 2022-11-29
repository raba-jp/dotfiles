final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.45.133";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v${version}/brave-browser_${version}_amd64.deb";
      sha256 = "0xfzvcvdvkyqp1sbkr4md6nij4jp626112ainnybsdcm5zazinwa";
    };
  });
}
