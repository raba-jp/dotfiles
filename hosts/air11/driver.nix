{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  pkgs,
  ...
}:
stdenv.mkDerivation rec {
  name = "rtl8723-${version}-${kernel.version}";
  version = "1";

  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtl8723du";
    rev = "3d1391d14a4e0b7129ffb9a9cd36bf31d22fc6d2";
    sha256 = "DsbZ6Ymp6KYxy4jVLclPLPRKW2BqkCEHRh/NkBnos84=";
  };

  hardeningDisable = ["pic" "format"];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  buildInputs = with pkgs; [gnumake git bc openssl mokutil gcc glibc];

  makeFlags = [
    "KVER=${kernel.modDirVersion}"
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
    install -p -m 644 8723du.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
  '';
}
