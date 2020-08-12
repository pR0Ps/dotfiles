#!/bin/bash

set -e

cd "$(dirname "$(realpath "$0")")"

for x in *; do
    [ -d "$x" ] || continue
    cd "$x"
    git pull --rebase --autostash
    cd - >/dev/null
done
