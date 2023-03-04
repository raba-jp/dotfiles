
# Auto generated
_: prev: {
  brave = prev.brave.overrideAttrs (_old: {
    version = "1.48.171";

    src = prev.fetchurl {
      url = "https://github.com/brave/brave-browser/releases/download/v1.48.171/brave-browser_1.48.171_amd64.deb";
      sha256 = "16s6bdw22y3knrfv3q53mabd0cxd61m6g63h6vy6k8l8bw34xlfx";
    };
  });
}
