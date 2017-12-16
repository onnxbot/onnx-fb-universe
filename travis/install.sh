#!/bin/bash

source "$(dirname $(readlink -e "${BASH_SOURCE[0]}"))/setup.sh"

CMAKE_ARGS='-DUSE_ATEN=ON' exec "$top_dir/install.sh"
