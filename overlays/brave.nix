
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.46.153";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.46.153/brave-browser_1.46.153_amd64.deb";
      sha256 = "08i36yc51hy9b3vk2320n75zalvg3sm46v57rp2yxf7izssbjd8f";
    };
  });
}
