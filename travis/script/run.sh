#!/bin/bash

top_dir=$(dirname $(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}"))))
source "$top_dir/setup.sh"

# Run tests in onnx repo
pip install pytest-cov nbval
cd "$REPOS_DIR/onnx"
pytest

# Run tests in onnx-caffe2 repo
pip install psutil tabulate
cd "$REPOS_DIR/onnx-caffe2"
pytest

# Run tests in onnx-pytorch repo
cd "$REPOS_DIR/onnx-pytorch"
make test
