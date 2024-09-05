#!/usr/bin/env bash

set -euxo pipefail

if [ "${REMOTE_CONTAINERS}" != 'true' ]; then
	echo 'This script does not support running outside of DevContainer. Please see the README.md.'
	exit 1
fi

has_nix=$(which nix)
if [ $? -ne 0 ]; then
	echo '`nix` command does not executable.'
fi

check_arch=$(uname -m)
arch=""
case "${check_arch}" in
"aarch64")
	arch="aarch64"
	;;
"arm64")
	arch="aarch64"
	;;
"x86_64")
	arch="x86_64"
	;;
"amd64")
	arch="x86_64"
	;;
*)
	echo 'Unexpected CPU architecture. fallback to x86_64.'
	arch="x86_64"
	;;
esac

nix build .#homeConfigurations.${arch}-linux.devcontainer.activatePackage
./result/activate
