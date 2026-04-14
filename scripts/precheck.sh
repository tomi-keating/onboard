#!/bin/sh

if xcode-select --print-path >/dev/null 2>&1; then
    echo "Detect Command Line Tools"
    exit 0
fi

if ! xcode-select --install; then
    echo "Command Line Tools cannot be automatically installed. Please download it from https://developer.apple.com/download/all/ and install it manually before continuing."
    exit 1
fi
