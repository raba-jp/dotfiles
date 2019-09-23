#!/bin/sh
set -e

version='1.9.0'
mitamae_version="mitamae-${version}"

if ! [ -f "bin/${mitamae_version}" ]; then
  case "$(uname)" in
    "Darwin")
      mitamae_bin="mitamae-x86_64-darwin"
      ;;
    "Linux")
      mitamae_bin="mitamae-x86_64-linux"
      ;;
    *)
      echo "unknown uname: $(uname)"
      exit 1
      ;;
  esac

  wget -O "bin/${mitamae_bin}.tar.gz" "https://github.com/itamae-kitchen/mitamae/releases/download/v${version}/${mitamae_bin}.tar.gz"
  tar xvzf "bin/${mitamae_bin}.tar.gz"

  rm "bin/${mitamae_bin}.tar.gz"
  mv "${mitamae_bin}" "bin/${mitamae_version}"
  chmod +x "bin/${mitamae_version}"
fi

ln -sf "${mitamae_version}" bin/mitamae
