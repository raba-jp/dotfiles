
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (old: rec {
    version = "1.49.14";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.49.14/brave-browser-nightly_1.49.14_amd64.deb";
      sha256 = "02jd244plpcv4qfklh6ra9cjk5kvfkym2dxqxgfhmk0vcswydzdg";
    };
  });
}
