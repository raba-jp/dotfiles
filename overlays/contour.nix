final: prev:
let version = "0.2.3.183";
in
{
  contour = prev.contour.overrideAttrs (old: {
    version = version;
    src = prev.fetchFromGitHub {
      owner = "christianparpart";
      repo = "contour";
      rev = "v${version}";
      sha256 = "Cn0A0NvVWWFy8gIH8H8VScuDsYIk6S3+uy/uAdaqy6o=";
      fetchSubmodules = true;
    };
  });
}
