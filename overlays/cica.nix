final: prev: let
  version = "5.0.3";
in {
  cica = prev.fetchzip {
    name = "cica-${version}";

    url = "https://github.com/miiton/Cica/releases/download/v${version}/Cica_v${version}.zip";
    sha256 = "sha256-IM8KpR069FngrAUY02ESK1rW3ANbouuiglwSITrHQyw=";

    postFetch = ''
      mkdir -p $out/share/fonts/cica
      unzip -j $downloadedFile \*.ttf -d $out/share/fonts/cica
    '';

    meta = with prev.lib; {
      homepage = "https://github.com/miiton/Cica";
      license = licenses.ofl;
      maintainers = with maintainers; [raba-jp];
      platforms = platforms.all;
    };
  };
}
