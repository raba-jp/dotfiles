inputs: final: prev:
let
  pname = "cachix";
  version = "latest";
  name = "${pname}-${version}";
in
{
  cachix = prev.stdenv.mkDerivation {
    name = name;
    version = version;

    src = inputs.cachix.packages.${prev.system}.cachix;

    isLibrary = false;
    isExecutable = true;
    installPhase = ''
      install -m755 -D bin/cachix $out/bin/cachix
    '';
  };
}

