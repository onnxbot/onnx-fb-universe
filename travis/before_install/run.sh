#!/bin/bash

top_dir=$(dirname $(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}"))))
source "$top_dir/setup.sh"

# Install protobuf
pb_version="2.6.1"
pb_dir="$CACHE_DIR/pb"
mkdir -p "$pb_dir"
wget -qO- "https://github.com/google/protobuf/releases/download/v$pb_version/protobuf-$pb_version.tar.gz" | tar -xvz -C "$pb_dir" --strip-components 1
ccache -z
cd "$pb_dir" && ./configure && make && make check && sudo make install && sudo ldconfig
ccache -s

# # Checkout
# $CMD_TOOLS checkout "$CONFIG_FILE" -o "$REPOS_DIR"
