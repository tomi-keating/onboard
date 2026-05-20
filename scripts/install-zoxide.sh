#!/bin/sh
set -e

brew install zoxide

if ! grep -q 'zoxide init zsh' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
fi

if ! grep -q 'zoxide init bash' ~/.bashrc 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
fi
