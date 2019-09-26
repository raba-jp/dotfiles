#!/bin/sh
set -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)

git submodule init
git submodule update

$SCRIPT_DIR/setup.sh

TARGET="./roles/local.rb"
if [ $# -eq 1 ]; then
  TARGET="$1"
fi

case "$(uname)" in
  "Darwin") ./bin/mitamae local $TARGET ;;
  *)  sudo -E ./bin/mitamae local $TARGET ;;
esac
