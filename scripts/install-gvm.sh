#!/bin/sh
set -e

brew install bison

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

[ -s "$HOME/.gvm/scripts/gvm" ] && . "$HOME/.gvm/scripts/gvm"

gvm install go1.24.13
gvm use go1.24.13 --default
