final: prev:
{
  vim-startuptime = prev.buildGoModule rec {
    pname = "vim-startuptime";
    version = "1.2.0";

    src = prev.fetchFromGitHub {
      owner = "rhysd";
      repo = "vim-startuptime";
      rev = "v${version}";
      sha256 = "sha256-GVOxCZOT2JmjD3ugFjGlwecnaT7v+lWu+X+18P99m04=";

    };
    vendorSha256 = "sha256-pQpattmS9VmO3ZIQUFn66az8GSmB4IvYhTTCFn6SUmo=";

    doCheck = false;
    doInstallCheck = false;

    meta = with prev.lib; {
      homepage = "https://github.com/rhysd/vim-startuptime";
      license = licenses.mit;
    };
  };
}
