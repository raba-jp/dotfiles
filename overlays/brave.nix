# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.56.20";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.56.20/brave-browser_1.56.20_amd64.deb";
      sha256 = "1smiqsbn1l0d1lxc5zbqv54mm5kq5ss0cqhq95y7bfq5il03igmr";
    };
  });
}
