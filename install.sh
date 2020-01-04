#!/bin/sh
set -e

cd `dirname $0`
./bin/setup_mitamae

if [ "$(uname)" = 'Darwin' ]; then
	./bin/mitamae local -j darwin.json ./bootstrap.rb
fi

if [ "$(cat /etc/arch-release)" = 'Manjaro Linux' ]; then
	sudo ./bin/mitamae local -j manjaro.json ./bootstrap.rb
fi
