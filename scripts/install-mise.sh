#!/bin/sh
set -e

curl https://mise.run | sh

if ! grep -q 'mise activate zsh' ~/.zshrc 2>/dev/null; then
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
fi

if ! grep -q 'mise activate bash' ~/.bashrc 2>/dev/null; then
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
fi
