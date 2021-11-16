final: prev:
let version = "0.23.0";
in {
  tilt = prev.tilt.overrideAttrs (old: {
    version = version;
    src = prev.fetchFromGitHub {
      owner = "tilt-dev";
      repo = "tilt";
      rev = "v${version}";
      sha256 = "yK2SOyWYriYzMaVKALzbBNgU0U1R+ChWGAd91iXeQuw=";
    };
  });
}
