
# Auto generated
final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.47.167";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.47.167/brave-browser_1.47.167_amd64.deb";
      sha256 = "09za45q4pla3nnb6k82vxc9prl2ayn3rqp7v4xqk4cc08b1axklz";
    };
  });
}
