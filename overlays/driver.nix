{ stdenv, lib, fetchFromGitHub, kernel, ... }:
stdenv.mkDerivation rec {
  name = "rtl8723-${version}-${kernel.version}";
  version = "1";

  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtl8723du";
  };

  hardeningDisable = [ "pic" "format" ];
  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "INSTALL_MOD_PATH=$(out)"
  ];
}
