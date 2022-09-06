_final: prev: let
  version = "1.0.0";
in {
  udev-gothic = prev.fetchzip {
    name = "udev-gothic-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_v${version}.zip";
    sha256 = "sha256-Pn3fe7UgJQbTHo/fU/7s2iT06J9BHRlFm5mdVStO6eY=";

    postFetch = ''
      mkdir -p $out/share/fonts/udev-gothic
      unzip -j /build/UDEVGothic_v${version}.zip \*.ttf -d $out/share/fonts/udev-gothic
    '';

    meta = with prev.lib; {
      homepage = "https://github.com/yuru7/udev-gothic";
      license = licenses.ofl;
      maintainers = with maintainers; [raba-jp];
      platforms = platforms.all;
    };
  };

  udev-gothic-nf = prev.fetchzip {
    name = "udev-gothic-nf-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_NF_v${version}.zip";
    sha256 = "sha256-7KP0jmFDK/IAXg8oW10NR7r0qvjix/nhrvnRXYbw1Zk=";

    postFetch = ''
      mkdir -p $out/share/fonts/udev-gothic-nf
      unzip -j /build/UDEVGothic_NF_v${version}.zip \*.ttf -d $out/share/fonts/udev-gothic-nf
    '';

    meta = with prev.lib; {
      homepage = "https://github.com/yuru7/udev-gothic";
      license = licenses.ofl;
      maintainers = with maintainers; [raba-jp];
      platforms = platforms.all;
    };
  };
}
