# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.63.161";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.63.161/brave-browser_1.63.161_amd64.deb";
      sha256 = "079i11rcnj2zs7dxdcz98sfl1iln6cji5cmg9vnxl7iwpzyi02hl";
    };
  });
}
