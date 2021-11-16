final: prev:
let version = "5.0.2";
in {
  cica = prev.fetchzip {
    name = "cica-${version}";

    url =
      "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}_with_emoji.zip";
    sha256 = "0zh1n5x1swgh72pyzgkvajs9r4xn172v6shl7978gjbh9xlqb8a2";

    postFetch = ''
      mkdir -p $out/share/fonts/cica
      unzip -j $downloadedFile \*.ttf -d $out/share/fonts/cica
    '';

    meta = with prev.lib; {
      homepage = "https://github.com/miiton/Cica";
      license = licenses.ofl;
      maintainers = with maintainers; [ raba-jp ];
      platforms = platforms.all;
    };
  };
}
