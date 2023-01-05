# dotfiles

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/raba-jp/dotfiles/build.yaml?branch=main&style=for-the-badge)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/raba-jp/dotfiles/activate.yaml?branch=main&label=Deploy&style=for-the-badge)

My NixOS and macOS configurations.

## Information

- Terminal emulator: WezTerm
- Shell: fish
- Editor: Neovim, Helix
- Browser: Brave
- Uses the [Catppuccin](https://github.com/catppuccin/catppuccin) theme

## Prerequirement
- [Nix](https://nixos.org/download.html#download-nix)

## Setup

### NixOS

```bash
sudo nixos-rebuild switch --flake .#{{hostName}}
```

### macOS

```bash
nix build .#darwinConfigurations.{{hostName}}.system
./result/sw/bin/darwin-rebuild switch --flake .#{{hostName}}
```
