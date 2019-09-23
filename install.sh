#!/bin/sh
set -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)

$SCRIPT_DIR/setup.sh

case "$(uname)" in
  "Darwin") ./bin/mitamae local $@ ./roles/local.rb ;;
  *)  sudo -E bin/mitamae local $@ ./roles/local.rb ;;
esac
