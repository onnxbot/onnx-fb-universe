#!/bin/bash

top_dir=$(dirname $(dirname $(dirname $(readlink -e "${BASH_SOURCE[0]}"))))
source "$top_dir/setup.sh"

# Install caffe
ccache -z
pip install -b "$BUILD_DIR/caffe2" "file://$REPOS_DIR/caffe2#egg=caffe2"
ccache -s

# Install onnx
ccache -z
pip install -b "$BUILD_DIR/onnx" -e "file://$REPOS_DIR/onnx#egg=onnx"
ccache -s

# Install onnx-caffe2
ccache -z
pip install -b "$BUILD_DIR/onnx-caffe2" -e "file://$REPOS_DIR/onnx-caffe2#egg=onnx-caffe2"
ccache -s

# Install pytorch
pip install pyaml
ccache -z
pip install -b "$BUILD_DIR/pytorch" "file://$REPOS_DIR/pytorch#egg=torch"
ccache -s

# Install onnx-pytorch
ccache -z
pip install -b "$BUILD_DIR/onnx-pytorch" "file://$REPOS_DIR/onnx-pytorch#egg=onnx-pytorch"
ccache -s
