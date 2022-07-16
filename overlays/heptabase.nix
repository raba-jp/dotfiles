_final: prev: let
  pname = "heptabase";
  version = "0.170.0";
  name = "heptabase-${version}";
  src = prev.fetchurl {
    url = "https://github.com/heptameta/project-meta/releases/download/v${version}/Hepta-${version}.AppImage";
    sha256 = "01wkxvf6ly10qm24j0lnabckpbdmbdsqyk10xw86irnnpy39pzh0";
  };
  appimageContents = prev.appimageTools.extractType2 {inherit name src;};
in {
  heptabase = prev.appimageTools.wrapType2 {
    inherit name src;

    extraPkgs = pkgs: with pkgs; [];

    extraInstallCommands = ''
      mv $out/bin/${name} $out/bin/${pname}
      install -m 444 -D ${appimageContents}/project-meta.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/project-meta.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/0x0/apps/project-meta.png \
        $out/share/icons/hicolor/512x512/apps/project-meta.png
    '';
  };
}
