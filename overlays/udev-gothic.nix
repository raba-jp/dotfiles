final: prev:
let version = "0.1.0";
in
{
  udev-gothic = prev.fetchzip {
    name = "udev-gothic-v${version}";

    url = "https://github.com/yuru7/udev-gothic/releases/download/v${version}/UDEVGothic_v${version}.zip";
    sha256 = "+I9bt1jxeiUMLoIcYKwXaYjHAbssF8RUuknSQaunPFk=";

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
    sha256 = "j0GSIMRMkSoEHRandSpfbX8DwqdtmFL8wTKQm7weoCY=";

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
