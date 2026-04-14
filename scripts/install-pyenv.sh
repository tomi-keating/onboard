#!/bin/sh
set -e

brew install pyenv

echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc

brew install openssl readline sqlite3 xz tcl-tk@8 libb2 zstd zlib pkgconfig

export PYENV_ROOT="$HOME/.pyenv"
[ -d "$PYENV_ROOT/bin" ] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

pyenv install 3.12.13
pyenv global 3.12.13
