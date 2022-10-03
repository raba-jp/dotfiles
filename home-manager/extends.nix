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
    python
    black
    poetry
    openjdk
    clojure
    clj-kondo
    # cljstyle
    leiningen
    golangci-lint
    actionlint
    taplo
    rclone
    bun
    deno
    cue
    ecspresso
    tfmigrate
  ];
}
