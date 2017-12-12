from __future__ import absolute_import
from __future__ import division
from __future__ import print_function
from __future__ import unicode_literals

import os


onnx_model_dir = os.path.join(os.path.dirname(
    os.path.realpath(__file__)), os.pardir, "repos", "onnx", "onnx",
    "backend", "test", "data", "model")


pytorch_converted_dir = os.path.join(onnx_model_dir, "pytorch-converted")


pytorch_operator_dir = os.path.join(onnx_model_dir, "pytorch-operator")


def output_dir(test_name, root_dir=pytorch_converted_dir):
    output_dir = os.path.join(root_dir, test_name)
    if not os.path.exists(output_dir):
        return output_dir
    i = 0
    while True:
        output_dir = os.path.join(root_dir, "{}_{}".format(test_name, i))
        if not os.path.exists(output_dir):
            return output_dir
        i += 1
