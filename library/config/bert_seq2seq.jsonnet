{
  "dataset_reader": {
    "type": "bert_seq2seq_reader",
    "source_tokenizer": {
      "word_splitter": "bert-basic"
    },
    "source_token_indexers": {
      "bert": {
        "type": "bert-pretrained",
        "pretrained_model": "/home/liangjunjun/uncased_L-24_H-1024_A-16/",
        "do_lowercase": true,
        "use_starting_offsets": false
      }
    }
  },
  "train_data_path": "/home/liangjunjun/story-generator/data/final_train.txt",
  "validation_data_path": "/home/liangjunjun/story-generator/data/final_test.txt",
  "model": {
    "type": "bert_seq2seq",
    "vocab_file": "/home/liangjunjun/uncased_L-24_H-1024_A-16/vocab.txt",
    "source_embedder":{
      "allow_unmatched_keys": true,
      "embedder_to_indexer_map": {
        "bert": [
          "bert",
           null,
          "bert-type-ids"
        ]
      },
      "token_embedders": {
        "bert": {
          "type": "bert-pretrained",
          "pretrained_model": "/home/liangjunjun/uncased_L-24_H-1024_A-16/",
          "requires_grad": true,
          "top_layer_only": true
        }
      }
    },
    "target_embedding_dim": 1000
  },
  "iterator": {
    "type": "bucket",
    "sorting_keys": [
      [
        "source_tokens","num_tokens"
      ]
    ],
    "batch_size": 24,
    "max_instances_in_memory": 600
  },
  "trainer": {
    "num_epochs": 50,
    "grad_norm": 5,
    "patience": 5,
    "validation_metric": "-loss",
    "cuda_device": 3,
    "optimizer": {
      "type": "bert_adam",
      "lr": 4e-3,
      "warmup": 0.01,
      "t_total": 1000000
    }
  }
}
