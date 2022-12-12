{
  lib,
  fetchzip,
  ...
}: let
  version = "1.0.1";
in
  fetchzip {
    name = "udev-gothic-nf-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_NF_v${version}.zip";
    sha256 = "sha256-Hrzc+eXnoCdrGYFi68V0SGZR13gQBbDRN3NGug4J4ic=";
    postFetch = ''
      mkdir -p $out/share/fonts/udev-gothic-nf
      mv $out/*.ttf $out/share/fonts/udev-gothic-nf
    '';

    meta = with lib; {
      homepage = "https://github.com/yuru7/udev-gothic";
      license = licenses.ofl;
      platforms = platforms.all;
    };
  }
