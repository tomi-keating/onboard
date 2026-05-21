#!/bin/sh
set -e

brew install starship

if ! grep -q 'starship init zsh' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

if ! grep -q 'starship init bash' ~/.bashrc 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi
