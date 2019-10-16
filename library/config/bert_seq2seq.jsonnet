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
  "train_data_path": "/home/liangjunjun/story-generator/rocstory_plan_write/test.dev",
  "validation_data_path": "/home/liangjunjun/story-generator/rocstory_plan_write/test.dev",
  "model": {
    "type": "bert_seq2seq",
    "vocab_file": "/home/liangjunjun/uncased_L-24_H-1024_A-16/vocab.txt",
    "source_embedder": {
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
    "target_embedding_dim": 300
  },
  "iterator": {
    "type": "bucket",
    "sorting_keys": [
      [
        "source_tokens","num_tokens"
      ]
    ],
    "batch_size": 9,
    "max_instances_in_memory": 600
  },
  "trainer": {
    "num_epochs": 20,
    "grad_norm": 5,
    "patience": 10,
    "validation_metric": "+BLEU",
    "cuda_device": -1,
    "optimizer": {
      "type": "bert_adam",
      "lr": 4e-5,
      "warmup": 0.1,
      "t_total": 40000
    }
  }
}