
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: rec {
    version = "1.47.186";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.47.186/brave-browser_1.47.186_amd64.deb";
      sha256 = "1wkwqsw3n0s82xgcsjcrdhvkxx7m7rzf79kxf8z42z5yq26y9cp3";
    };
  });
}
