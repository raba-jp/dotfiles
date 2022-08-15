{pkgs, ...}: {
  home.packages = with pkgs; [
    google-cloud-sdk
    bazelisk
    terraform
    terraformer
    terragrunt
    driftctl
    buf
    nodejs
    yarn
    aws-vault
    yubikey-manager
    sops
    age
    ssh-to-age
    python
    black
    poetry
    vim-startuptime
    openjdk
    clojure
    clj-kondo
    # cljstyle
    leiningen
    golangci-lint
    actionlint
    taplo
  ];
}
