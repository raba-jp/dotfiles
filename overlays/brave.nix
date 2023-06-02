# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.52.117";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.52.117/brave-browser_1.52.117_amd64.deb";
      sha256 = "01nmp7iqgrm3692zmgpq3cpxf620h9g4rrij29b2w6fg0x2cm3x0";
    };
  });
}
