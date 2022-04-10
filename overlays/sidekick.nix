{ stdenv
, lib
, fetchurl
, dpkg
, alsa-lib
, at-spi2-atk
, at-spi2-core
, atk
, cairo
, cups
, dbus
, expat
, fontconfig
, freetype
, gdk-pixbuf
, glib
, gnome
, gsettings-desktop-schemas
, gtk3
, libpulseaudio
, libuuid
, libdrm
, libX11
, libXcomposite
, libXcursor
, libXdamage
, libXext
, libXfixes
, libXi
, libxkbcommon
, libXrandr
, libXrender
, libXScrnSaver
, libxshmfence
, libXtst
, mesa
, nspr
, nss
, pango
, pipewire
, udev
, xorg
, zlib
, xdg-utils
, wrapGAppsHook
, commandLineArgs ? ""
}:
let
  version = "98.17.0.18436-2e68cb9";

  rpath = lib.makeLibraryPath [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libpulseaudio
    libX11
    libxkbcommon
    libXScrnSaver
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libxshmfence
    libXtst
    libuuid
    mesa
    nspr
    nss
    pango
    pipewire
    udev
    xdg-utils
    xorg.libxcb
    zlib
  ];
in
stdenv.mkDerivation {
  name = "sidekick-${version}";

  version = version;

  src = fetchurl {
    url = "https://api.meetsidekick.com/downloads/df/linux/deb";
    sha256 = "039b9sn46b56gsf4v81i1g772y19443ag00zzv560s95ddaaa8z2";
  };

  dontConfigure = true;
  dontBuild = true;
  dontPatchELF = true;
  doInstallCheck = true;

  unpackPhase = "${dpkg}/bin/dpkg-deb --fsys-tarfile $src | tar -x --no-same-permissions --no-same-owner";

  nativeBuildInputs = [ dpkg wrapGAppsHook ];
  buildInputs = [ glib gsettings-desktop-schemas ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out $out/bin

    cp -R usr/share $out
    cp -R opt/ $out/opt

    export BINARYWRAPPER=$out/opt/meetsidekick.com/sidekick/sidekick-browser

    # Fix path to bash in $BINARYWRAPPER
    substituteInPlace $BINARYWRAPPER \
        --replace /bin/bash ${stdenv.shell}

    ln -sf $BINARYWRAPPER $out/bin/sidekick-browser-stable

    for elf in $out/opt/meetsidekick.com/sidekick/{chrome,chrome-sandbox,chrome_crashpad_handler,nacl_helper}; do
      patchelf \
          --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
          --set-rpath "${rpath}" $elf
    done

    # Fix paths
    substituteInPlace $out/share/applications/sidekick-browser.desktop \
        --replace /usr/bin/sidekick-browser-stable $out/bin/sidekick-browser-stable
    substituteInPlace $out/share/gnome-control-center/default-apps/sidekick-browser.xml \
        --replace /opt/meetsidekick.com $out/opt/meetsidekick.com
    substituteInPlace $out/share/menu/sidekick-browser.menu \
        --replace /opt/meetsidekick.com $out/opt/meetsidekick.com
    substituteInPlace $out/opt/meetsidekick.com/sidekick/default-app-block \
        --replace /opt/meetsidekick.com $out/opt/meetsidekick.com

    # Correct icons location
    icon_sizes=("16" "24" "32" "48" "64" "128" "256")
    for icon in ''${icon_sizes[*]}
    do
        mkdir -p $out/share/icons/hicolor/$icon\x$icon/apps
        ln -s $out/opt/meetsidekick.com/sidekick/product_logo_$icon.png $out/share/icons/hicolor/$icon\x$icon/apps/sidekick-browser.png
    done

    # Replace xdg-settings and xdg-mime
    ln -sf ${xdg-utils}/bin/xdg-settings $out/opt/meetsidekick.com/sidekick/xdg-settings
    ln -sf ${xdg-utils}/bin/xdg-mime $out/opt/meetsidekick.com/sidekick/xdg-mime

    runHook postInstall
  '';

  preFixup = ''
    # Add command line args to wrapGApp.
    gappsWrapperArgs+=(--add-flags ${lib.escapeShellArg commandLineArgs})
  '';

  installCheckPhase = ''
    # Bypass upstream wrapper which suppresses errors
    $out/opt/meetsidekick.com/sidekick/sidekick-browser --version
  '';

  meta = with lib; {
    homepage = "https://www.meetsidekick.com/";
    description = "Sidekick is designed for the ultimate online work experience and brings together every web tool you use.";
    platforms = platforms.linux;
  };
}
