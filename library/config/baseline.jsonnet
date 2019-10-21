{
  "dataset_reader": {
    "type": "baseline_seq2seq",
    "source_tokenizer": {
      "type": "word"
    }
  },
  "train_data_path": "/home/liangjunjun/story-generator/data/final_train.txt",
  "validation_data_path": "/home/liangjunjun/story-generator/data/final_test.txt",
  "evaluate_on_test": true,
  "model": {
    "type": "simple_seq2seq",
    "source_embedder": {
      "type": "basic",
      "token_embedders": {
        "tokens": {
          "type": "embedding",
          "embedding_dim": 300,
          "trainable": true
        }
      }
    },
    "encoder": {
      "type": "lstm",
      "input_size": 300,
      "hidden_size": 512,
      "num_layers": 2
    },
    "max_decoding_steps": 150,
    "attention_function": {"type": "dot_product"},
    "beam_size": 1,
    "scheduled_sampling_ratio": 0.9
  },
  "iterator": {
    "type": "bucket",
    "padding_noise": 0.0,
    "batch_size" : 128,
    "sorting_keys": [["source_tokens", "num_tokens"]],
    "max_instances_in_memory": 600
  },
  "trainer": {
    "optimizer": {
      "type": "adam",
      "lr": 0.001
    },
    "grad_clipping": 5.0,
    "grad_norm": 2.0,
    "validation_metric": "+BLEU",
    "num_epochs": 500,
    "cuda_device": [0,3]
  }
}