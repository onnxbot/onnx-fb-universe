#!/bin/bash

set -ex

if [[ "$(uname)" == 'Darwin' ]]; then
    script_path=$(realpath -e "${BASH_SOURCE[0]}")
else
    script_path=$(readlink -e "${BASH_SOURCE[0]}")
fi
top_dir=$(dirname "$script_path")
REPOS_DIR="$top_dir/repos"
BUILD_DIR="$top_dir/build"
mkdir -p "$BUILD_DIR"

_pip_install() {
    if [[ -n "$CI" ]]; then
        ccache -z
    fi
    if [[ -n "$CI" ]]; then
        time pip install "$@"
    else
        pip install "$@"
    fi
    if [[ -n "$CI" ]]; then
        ccache -s
    fi
}

# Install caffe2
_pip_install -b "$BUILD_DIR/caffe2" "file://$REPOS_DIR/caffe2#egg=caffe2"

# Install onnx
_pip_install -b "$BUILD_DIR/onnx" "file://$REPOS_DIR/onnx#egg=onnx"

# Install onnx-caffe2
_pip_install -b "$BUILD_DIR/onnx-caffe2" "file://$REPOS_DIR/onnx-caffe2#egg=onnx-caffe2"

# Install pytorch
pip install -r "$REPOS_DIR/pytorch/requirements.txt"
_pip_install -b "$BUILD_DIR/pytorch" "file://$REPOS_DIR/pytorch#egg=torch"

# Install onnx-pytorch
_pip_install -b "$BUILD_DIR/onnx-pytorch" "file://$REPOS_DIR/onnx-pytorch#egg=onnx-pytorch"
