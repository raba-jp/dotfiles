final: { stdenv, lib, autoreconfHook, perl, groff, texinfo, util-linux, yodl, ... }@prev:
{
  zsh = prev.zsh.overrideAttrs (old: {
    nativeBuildInputs = [ autoreconfHook perl groff texinfo ]
      ++ lib.optionals stdenv.isLinux [ util-linux yodl ];
  });
}
