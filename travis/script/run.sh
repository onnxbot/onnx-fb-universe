#!/bin/bash

top_dir=$(dirname $(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}"))))
source "$top_dir/setup.sh"

pip install pytest-cov nbval

# Run tests in onnx repo
cd "$REPOS_DIR/onnx"
pytest

# Run tests in onnx-caffe2 repo
cd "$REPOS_DIR/onnx-caffe2"
pytest
