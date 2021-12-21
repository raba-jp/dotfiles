final: prev:

let
  appimageTools = prev.appimageTools;
  fetchurl = prev.fetchurl;
  gsettings-desktop-schemas = prev.gsettings-desktop-schemas;
  gtk3 = prev.gtk3;
  lib = prev.lib;

  pname = "stack";
  version = "3.40.0";
  name = "${pname}-${version}";

  src = fetchurl {
    name = name;
    url =
      "https://binaries.getstack.app/builds/prod/linux/Stack%20${version}-x86_64.AppImage";
    sha256 = "104qg8k77n1d4ln4nizc6q7r9b1s6257z1ajdavbdca4y11r29i6";
  };

  appimageContents = appimageTools.extractType2 { inherit name src; };
in {
  stack = appimageTools.wrapType2 rec {
    inherit name src;

    profile = ''
      export LC_ALL=C.UTF-8
      export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
    '';

    multiPkgs = null;
    extraPkgs = appimageTools.defaultFhsEnvArgs.multiPkgs;
    extraInstallCommands = ''
      mv $out/bin/{${name},${pname}}
      install -m 444 -D ${appimageContents}/Stack.desktop $out/share/applications/Stack.desktop
      install -m 444 -D ${appimageContents}/usr/share/icons/hicolor/256x256/apps/Stack.png \
        $out/share/icons/hicolor/256x256/apps/Stack.png
      substituteInPlace $out/share/applications/Stack.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
    '';

    meta = with lib; { platforms = [ "x86_64-linux" ]; };
  };
}
