{
  lib,
  fetchzip,
  ...
}: let
  version = "1.0.1";
in
  fetchzip {
    name = "udev-gothic-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_v${version}.zip";
    sha256 = "sha256-Bv/g1KsUQOVmHtuTieMeEhVP2hUvEkpAD49ZdQvDaNI=";

    postFetch = ''
      mkdir -p $out/share/fonts/udev-gothic
      mv $out/*.ttf $out/share/fonts/udev-gothic
    '';

    meta = with lib; {
      homepage = "https://github.com/yuru7/udev-gothic";
      license = licenses.ofl;
      platforms = platforms.all;
    };
  }
