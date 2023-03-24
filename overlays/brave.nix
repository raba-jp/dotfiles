# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.49.128";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.49.128/brave-browser_1.49.128_amd64.deb";
      sha256 = "09bzx8wv36nr0vfnd7mb6dbc1rknhpwqzjka8zy9pfji2g70yw2d";
    };
  });
}
