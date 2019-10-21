# -*- coding: UTF-8 -*-
"""
@author: liangjunjun
@contact: liangjunjun@pku.edu.cn
@version: v0.0.1
@file: extractor.py
@time: 2019/9/21 22:03
@desc: 
"""
from allennlp.models.archival import load_archive
from allennlp.predictors import Predictor
from allennlp.common.util import import_submodules

import_submodules('library')


class StoryGenerator(object):
    def __init__(self, model_path, cuda_device=2):
        archive = load_archive(model_path, cuda_device=cuda_device)
        self.predictor = Predictor.from_archive(archive, 'bert_seq2seq_predictor')

    def generate(self, source):
        target = self.predictor.predict_json({'source': source})
        target = target["predicted_tokens"]
        story = ' '.join(target)
        # for _target in target:
        #     _story = ' '.join(_target)
        #     story.append(_story)
        return story

    def processor_txt(self, file_path, output_path):
        """
        从txt中读取文件并将生成的故事写入output_path
        :param file_path:
        :param output_path:
        :return:
        """
        with open(file_path) as fin, open(output_path, 'w') as fout:
            source_list = fin.readlines()
            for line in source_list:
                if not line:
                    continue
                if '<EOL>' in line and len(line.split('<EOL>')) == 2:
                    line = line.replace('<EOT>', '★')
                    line_parts = line.split('<EOL>')
                else:
                    line_parts = line.split('<EOT>')
                story = self.generate(line_parts[0])
                print("主题是:", line_parts[0])
                print("生成故事是:",story)
                print("参考故事是:",line_parts[1])
                print('\n')
                # fout.write(story)
                # fout.write('\n')


if __name__ == "__main__":
    generator = StoryGenerator(
        model_path='/home/liangjunjun/story-generator/model/line2story',
        cuda_device=2)
    generator.processor_txt('/home/liangjunjun/story-generator/data/final_train.txt','/home/liangjunjun/story-generator/data/story_1.txt')
