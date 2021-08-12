#!/usr/bin/env bash

if [ "$(uname)" == 'Darwin' ]; then
	curl -L https://nixos.org/nix/install | sh -s -- --darwin-use-unencrypted-nix-store-volume

	nix-env -iA nixpkgs.nixUnstable
	grep 'experimental-features = nix-command flakes' ~/.config/nix/nix.conf
	if [ $? -ne 0 ]; then
		echo 'experimental-features = nix-command flakes' > ~/.config/nix/nix.conf
	fi
fi
