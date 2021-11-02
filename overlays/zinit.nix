self: super: {
  zinit = super.zinit.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "zdharma-continuum";
      repo = "zinit";
      rev = "v3.7";
      hash = "sha256-B+cTGz+U8MR22l6xXdRAAjDr+ulCk+CJ9GllFMK0axE=";
    };
  });
}
