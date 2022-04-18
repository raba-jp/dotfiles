final: prev:
let version = "1.0.0";
in
{
  udev-gothic = prev.fetchzip {
    name = "udev-gothic-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_v${version}.zip";
    sha256 = "LFzyndRTqJBBMiwb89jhDN4EHzOzHeS9kiO+chJB25s=";

    postFetch = ''
      mkdir -p $out/share/fonts/udev-gothic
      unzip -j $downloadedFile \*.ttf -d $out/share/fonts/udev-gothic
    '';

    meta = with prev.lib; {
      homepage = "https://github.com/yuru7/udev-gothic";
      license = licenses.ofl;
      maintainers = with maintainers; [ raba-jp ];
      platforms = platforms.all;
    };
  };

  udev-gothic-nf = prev.fetchzip {
    name = "udev-gothic-nf-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_NF_v${version}.zip";
    sha256 = "GWBDzkEUTpzGl+/euaQYQBbXAIbZOc10dj4jJNlD5OA=";

    postFetch = ''
      mkdir -p $out/share/fonts/udev-gothic-nf
      unzip -j $downloadedFile \*.ttf -d $out/share/fonts/udev-gothic-nf
    '';

    meta = with prev.lib; {
      homepage = "https://github.com/yuru7/udev-gothic";
      license = licenses.ofl;
      maintainers = with maintainers; [ raba-jp ];
      platforms = platforms.all;
    };
  };
}
