#!/bin/bash

top_dir=$(dirname $(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}"))))
source "$top_dir/setup.sh"

# Install GCC 5
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get install -y --no-install-recommends g++-5
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 60 \
     --slave /usr/bin/g++ g++ /usr/bin/g++-5

# Install protobuf
pb_version="2.6.1"
pb_dir="$CACHE_DIR/pb"
mkdir -p "$pb_dir"
wget -qO- "https://github.com/google/protobuf/releases/download/v$pb_version/protobuf-$pb_version.tar.gz" | tar -xvz -C "$pb_dir" --strip-components 1
ccache -z
cd "$pb_dir" && ./configure && make && make check && sudo make install && sudo ldconfig
ccache -s

# Checkout
$CMD_TOOLS checkout "$CONFIG_FILE" -o "$REPOS_DIR"
