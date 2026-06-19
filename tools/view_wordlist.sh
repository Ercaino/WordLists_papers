#!/bin/bash

TARGET="${1:-/usr/share/wordlists}"

if ! command -v tree &> /dev/null; then
    echo "Error: 'tree' is not installed. Install it and try again."
    exit 1
fi

if [ ! -d "$TARGET" ]; then
    echo "Directory not found: $TARGET"
    exit 1
fi

echo "Listing wordlists structure: $TARGET"
tree -L 2 --sort=name "$TARGET"
