# -*- coding: UTF-8 -*-
"""
@author: liangjunjun
@contact: liangjunjun@pku.edu.cn
@version: v0.0.1
@file: train_by_args.py
@time: 2019/9/27 17:28
@desc: 非命令行形式启动训练，主要可以用于调试
"""

from allennlp.commands.train import train_model_from_file
from allennlp.common.util import import_submodules
import_submodules('library')


CONFIG_PATH = '/home/liangjunjun/story-generator/library/config/baseline.jsonnet'
SERIALIZATION_DIR = '/home/liangjunjun/story-generator/model/test'

train_model_from_file(parameter_filename=CONFIG_PATH,
                      serialization_dir=SERIALIZATION_DIR,
                      force=True)