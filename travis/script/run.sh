#!/bin/bash

top_dir=$(dirname $(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}"))))
source "$top_dir/setup.sh"

# Run tests in onnx-pytorch repo
cd "$REPOS_DIR/onnx-pytorch"
make test
