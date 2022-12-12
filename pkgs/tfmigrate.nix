{
  lib,
  buildGoModule,
  fetchFromGitHub,
  ...
}:
buildGoModule rec {
  pname = "tfmigrate";
  version = "0.3.8";

  src = fetchFromGitHub {
    owner = "minamijoyo";
    repo = "tfmigrate";
    rev = "v${version}";
    sha256 = "sha256-syqHlZP/y6alUkEQj4vQIMVom+cSrMO9JJtTMQs7Kb0=";
  };
  vendorSha256 = "sha256-urcK4NzQwKYAPz8zxDv6dxB1JjKQe+CQdBfmRm9Q9Ig=";

  doCheck = false;
  doInstallCheck = false;

  meta = with lib; {
    homepage = "https://github.com/minamijoyo/tfmigrate";
    license = licenses.mit;
  };
}
