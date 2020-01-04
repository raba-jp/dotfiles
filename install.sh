#!/bin/sh
set -e

cd `dirname $0`
./bin/setup_mitamae

if [ "$(uname)" = 'Darwin' ]; then
	./bin/mitamae local -j darwin.json ./bootstrap.rb
fi

if [ -e /etc/arch-release ]; then
	sudo ./bin/mitamae local -j arch.json ./bootstrap.rb
fi
