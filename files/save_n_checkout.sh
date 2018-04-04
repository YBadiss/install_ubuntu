#!/bin/bash

src=$(git rev-parse --abbrev-ref HEAD)
dest=${@: -1}

if [ "$src" != "$dest" ]; then
    git stash save "$src"
    git checkout $*
    stash=$(git get-stash "$dest" | head -n 1)
    if [ ! -z "$stash" ]; then
        git stash apply $stash
        git stash drop $stash
    fi
fi
