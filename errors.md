1. Fastarg
```
  File "/workspace/pretrain_ssl_dense/experiment/imagenet/dino/vastai/../../../../src/train_ssl.py", line 378, in <module>
    main(config)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 63, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 35, in __call__
    return self.func(*args, **filled_args)
  File "/workspace/pretrain_ssl_dense/experiment/imagenet/dino/vastai/../../../../src/train_ssl.py", line 362, in main
    ImageNetTrainer.launch_from_args()
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 63, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 35, in __call__
    return self.func(*args, **filled_args)
  File "/workspace/pretrain_ssl_dense/src/train/trainer_dino.py", line 636, in launch_from_args
    ch.multiprocessing.spawn(cls._exec_wrapper, nprocs=ngpus_per_node, join=True, args=(None, ngpus_per_node, world_size, dist_url))
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 241, in spawn
    return start_processes(fn, args, nprocs, join, daemon, start_method="spawn")
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 197, in start_processes
    while not context.join():
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 158, in join
    raise ProcessRaisedException(msg, error_index, failed_process.pid)
torch.multiprocessing.spawn.ProcessRaisedException: 

-- Process 5 terminated with the following error:
Traceback (most recent call last):
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 68, in _wrap
    fn(i, *args)
  File "/workspace/pretrain_ssl_dense/src/train/trainer_dino.py", line 649, in _exec_wrapper
    cls.exec(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 63, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 41, in __call__
    raise e
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 35, in __call__
    return self.func(*args, **filled_args)
  File "/workspace/pretrain_ssl_dense/src/train/trainer_dino.py", line 656, in exec
    trainer = cls(gpu=gpu, ngpus_per_node=ngpus_per_node, world_size=world_size, dist_url=dist_url)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 63, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 41, in __call__
    raise e
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 35, in __call__
    return self.func(*args, **filled_args)
  File "/workspace/pretrain_ssl_dense/src/train/trainer_dino.py", line 93, in __init__
    self.train_loader = self.create_train_loader_ssl(train_dataset=train_dataset)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 63, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 38, in __call__
    raise TypeError("""Ambiguity overriding config arguments, use \
TypeError: Ambiguity overriding config arguments, use named parameter to resolve it
```

Solution:
