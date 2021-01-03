#!/bin/sh
set -e

cd $(dirname $0)
./bin/setup_mitamae

./bin/mitamae local ./bootstrap.rb
