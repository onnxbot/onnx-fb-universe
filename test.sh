#!/bin/bash

set -ex

if [[ "$(uname)" == 'Darwin' ]]; then
    script_path=$(realpath -e "${BASH_SOURCE[0]}")
else
    script_path=$(readlink -e "${BASH_SOURCE[0]}")
fi
top_dir=$(dirname "$script_path")
TEST_DIR="$top_dir/test"

python "$TEST_DIR/test_operators.py" -v
python "$TEST_DIR/test_models.py" -v
python "$TEST_DIR/test_caffe2.py" -v
python "$TEST_DIR/test_verify.py" -v
python "$TEST_DIR/test_pytorch_helper.py" -v
