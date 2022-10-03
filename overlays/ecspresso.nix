_final: prev: {
  ecspresso = prev.buildGoModule rec {
    pname = "ecspresso";
    version = "1.7.12";

    src = prev.fetchFromGitHub {
      owner = "kayac";
      repo = "ecspresso";
      rev = "v${version}";
      sha256 = "sha256-rW6G9TqJA3JxLq0BENBzPkfK8ieGydSyf9x/O8zgZMU=";
    };
    vendorSha256 = "sha256-illx3imap4yWFto89GafhGDKfnVj6ZCa2JT7ZDHNMnE=";

    subPackages = ["cmd/ecspresso"];

    ldflags = [
      "-s -w"
      "-X main.Version=v${version}"
    ];

    doCheck = false;
    doInstallCheck = false;

    meta = with prev.lib; {
      homepage = "https://github.com/kayac/ecspresso";
      license = licenses.mit;
    };
  };
}
