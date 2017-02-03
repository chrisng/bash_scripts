#!/usr/bin/env bash

set -eu
set -o pipefail

CNG=${foo:=cng}

ls foo  ||:
echo "Foo"
