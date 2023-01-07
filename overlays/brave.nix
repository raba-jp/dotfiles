
# Auto generated
final: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.47.165";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.47.165/brave-browser_1.47.165_amd64.deb";
      sha256 = "0swdaanq85smi5dv3qzyi5vdlzysyackph8xmiv5mjbz6dg52p73";
    };
  });
}
