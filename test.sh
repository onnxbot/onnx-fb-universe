#!/bin/bash

set -ex

top_dir=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
TEST_DIR="$top_dir/test"

python "$TEST_DIR/test_operators.py" -v
python "$TEST_DIR/test_models.py" -v
python "$TEST_DIR/test_caffe2.py" -v
python "$TEST_DIR/test_verify.py" -v
python "$TEST_DIR/test_pytorch_helper.py" -v
