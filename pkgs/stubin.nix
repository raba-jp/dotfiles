{
  lib,
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "stubin";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "k1LoW";
    repo = "stubin";
    rev = "v${version}";
    sha256 = "sha256-nLqZF36q09n/dc+RMQxxECA2Ku6g3M94X7kwZFwmJCw=";
  };
  vendorHash = "sha256-KTGnuVN0+HJ7xr7+/mKSrdfF5c+XW0wDLtn5F2nCL3M=";

  ldflags = [
    "-s -w"
  ];

  doCheck = false;
  doInstallCheck = false;

  meta = with lib; {
    homepage = "https://github.com/k1LoW/stubin";
    mainProgram = "stubin";
    license = licenses.mit;
  };
}
