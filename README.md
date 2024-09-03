# dotfiles


My macOS configurations.

## Prerequirement
- [Nix](https://nixos.org/download.html#download-nix)

## Setup

### macOS

```bash
nix build .#darwinConfigurations.{{hostName}}.system
./result/sw/bin/darwin-rebuild switch --flake .#{{hostName}}
```
