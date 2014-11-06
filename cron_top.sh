#!/bin/bash
set -eu
top -b -c -n 1 -d 1 > /tmp/top-$(date "+%Y-%m-%d_%H-%M-%S")
