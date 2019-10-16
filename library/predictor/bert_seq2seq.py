# -*- coding: UTF-8 -*-
"""
@author: liangjunjun
@contact: liangjunjun@pku.edu.cn
@version: v0.0.1
@file: bert_seq2seq.py
@time: 2019/10/7 20:46
@desc: 
"""
from overrides import overrides

from allennlp.common.util import JsonDict
from allennlp.data import Instance
from allennlp.predictors.predictor import Predictor


@Predictor.register('bert_seq2seq_predictor')
class BertSeq2SeqPredictor(Predictor):
    """
    Predictor for sequence to sequence models, including
    :class:`~allennlp.models.encoder_decoder.simple_seq2seq` and
    :class:`~allennlp.models.encoder_decoder.copynet_seq2seq`.
    """

    def predict(self, source: str) -> JsonDict:
        return self.predict_json({"source" : source})

    @overrides
    def _json_to_instance(self, json_dict: JsonDict) -> Instance:
        """
        Expects JSON that looks like ``{"source": "..."}``.
        """
        source = json_dict["source"]
        return self._dataset_reader.text_to_instance(source)
