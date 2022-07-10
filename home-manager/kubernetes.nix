{pkgs, ...}: {
  home.packages = with pkgs; [
    kubectl
    kubectx
    skaffold
    tilt
    kustomize
    kubernetes-helm
    stern
    kind
    conftest
    dive
  ];
}
