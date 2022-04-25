#!/usr/bin/env bash

SCRIPT_DIR=$(
	cd $(dirname $0)
	pwd
)

${SCRIPT_DIR}/scripts/install-nix.sh

if [ "$CODESPACES" = "true" ]; then
	. /home/codespace/.nix-profile/etc/profile.d/nix.sh
	nix build --no-link '.#homeConfigurations.vscode.activationPackage'
	"$(nix path-info '.#homeConfigurations.vscode.activationPackage')"/activate
fi
