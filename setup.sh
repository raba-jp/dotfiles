#!/usr/bin/env bash

SCRIPT_DIR=$(
	cd $(dirname $0)
	pwd
)

workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

if [ "$CODESPACES" = "true" ]; then

	sudo mkdir -m 0755 /nix
	sudo chown codespace /nix
	sudo groupadd nixbld

	for n in $(seq 1 10); do
		sudo useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(command -v nologin)" "nixbld$n"
	done

	echo "max-jobs = auto" | tee -a "$workdir/nix.conf" >/dev/null
	echo "trusted-users = root $USER" | tee -a "$workdir/nix.conf" >/dev/null
	echo "experimental-features = nix-command flakes" | tee -a "$workdir/nix.conf" >/dev/null

	curl -o /tmp/nix-install.sh -L https://nixos.org/nix/install
	chmod +x /tmp/nix-install.sh
	/tmp/nix-install.sh --no-daemon --nix-extra-conf-file "$workdir/nix.conf"
	. /home/codespace/.nix-profile/etc/profile.d/nix.sh
	nix build --no-link '.#homeConfigurations.codespace.activationPackage'
	"$(nix path-info '.#homeConfigurations.codespace.activationPackage')"/activate
else
	${SCRIPT_DIR}/scripts/install-nix.sh
fi
