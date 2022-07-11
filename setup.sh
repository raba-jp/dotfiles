#!/usr/bin/env bash

SCRIPT_DIR=$(
	cd $(dirname $0)
	pwd
)

# Configure Nix
add_config() {
	echo "$1" | tee -a "$workdir/nix.conf" >/dev/null
}

if [ "$CODESPACES" = "true" ]; then
	mkdir -m 0755 /nix
	chown codespace /nix
	groupadd nixbld

	for n in $(seq 1 10); do
		useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(command -v nologin)" "nixbld$n"
	done

	add_config "max-jobs = auto"
	add_config "trusted-users = root $USER"
	add_config "experimental-features = nix-command flakes"

	curl -o /tmp/nix-install.sh -L https://nixos.org/nix/install
	chmod +x /tmp/nix-install.sh
	/tmp/nix-install.sh --no-daemon
	. /home/codespace/.nix-profile/etc/profile.d/nix.sh
	nix build --no-link '.#homeConfigurations.codespace.activationPackage'
	"$(nix path-info '.#homeConfigurations.codespace.activationPackage')"/activate
else
	${SCRIPT_DIR}/scripts/install-nix.sh
fi
