#!/bin/sh

set -e

if [ "$(uname)" = "Darwin" ]; then
  brew install ruby
  gem install serverspec
else
  sudo apt-get install ruby
  sudo gem install serverspec
fi
