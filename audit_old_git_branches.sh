#!/bin/bash
set -eu

EXCLUDE_LIST="remote/origin/releases/"

for k in $(git branch -r --merged master | grep -v '\->' | sed s/^..//); do
    echo -e $(git log -1 --pretty=format:"%ci %cr" "$k")'\t'"$k"
done | sort | egrep -v "$EXCLUDE_LIST"
