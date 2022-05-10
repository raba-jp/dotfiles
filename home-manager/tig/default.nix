{pkgs, ...}: {
  xdg.enable = true;

  xdg.configFile."tig/config".text = ''
    bind generic h scroll-left
    bind generic j move-down
    bind generic k move-up
    bind generic l scroll-right
    bind generic g  none
    bind generic gg move-first-line
    bind generic gj next
    bind generic gk previous
    bind generic gp parent
    bind generic gP back
    bind generic gn view-next
    bind main    G move-last-line
    bind generic G move-last-line
  '';
}
