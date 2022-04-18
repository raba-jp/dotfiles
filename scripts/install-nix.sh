#!/usr/bin/env bash

URL="https://nixos.org/nix/install"

if [ "$(uname)" == 'Darwin' ]; then
	sudo xcodebuild -license accept
fi

if command -v nix >/dev/null; then
	echo "nix is already installed on this system."
else
	bash <(curl -L $URL) --daemon
	mkdir -p ~/.config/nix
	if ! grep 'experimental-features = nix-command flakes' ~/.config/nix/nix.conf; then
		echo 'experimental-features = nix-command flakes' >~/.config/nix/nix.conf
	fi
fi
