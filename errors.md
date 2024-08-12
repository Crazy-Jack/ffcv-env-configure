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

Install ffcv-ssl again since it's not using the ssl version of ffcv


2. Symbol Lookup

```
workspace/env/miniconda/envs/ffcv/bin/python3: symbol lookup error: /workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/lib/../../nvidia/cudnn/lib/libcudnn_cnn_infer.so.8: undefined symbol: _ZN15TracebackLoggerC1EPKc, version libcudnn_ops_infer.so.8
/workspace/env/miniconda/envs/ffcv/bin/python3: symbol lookup error: /workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/lib/../../nvidia/cudnn/lib/libcudnn_cnn_infer.so.8: undefined symbol: _ZN15TracebackLoggerC1EPKc, version libcudnn_ops_infer.so.8
Traceback (most recent call last):
  File "/workspace/pretrain_ssl_dense/experiment/imagenet/dino/vastai/../../../../src/train_ssl.py", line 378, in <module>
    main(config)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 64, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 35, in __call__
    return self.func(*args, **filled_args)
  File "/workspace/pretrain_ssl_dense/experiment/imagenet/dino/vastai/../../../../src/train_ssl.py", line 362, in main
    ImageNetTrainer.launch_from_args()
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 64, in result
    return func(*args, **kwargs)
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/fastargs/decorators.py", line 35, in __call__
    return self.func(*args, **filled_args)
  File "/workspace/pretrain_ssl_dense/src/train/trainer_dino.py", line 636, in launch_from_args
    ch.multiprocessing.spawn(cls._exec_wrapper, nprocs=ngpus_per_node, join=True, args=(None, ngpus_per_node, world_size, dist_url))
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 241, in spawn
    return start_processes(fn, args, nprocs, join, daemon, start_method="spawn")
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 197, in start_processes
    while not context.join():
  File "/workspace/env/miniconda/envs/ffcv/lib/python3.9/site-packages/torch/multiprocessing/spawn.py", line 148, in join
    raise ProcessExitedException(
torch.multiprocessing.spawn.ProcessExitedException: process 1 terminated with exit code 127
/workspace/env/miniconda/envs/ffcv/lib/python3.9/multiprocessing/resource_tracker.py:216: UserWarning: resource_tracker: There appear to be 8 leaked semaphore objects to clean up at shutdown
  warnings.warn('resource_tracker: There appear to be %d '
```

Solution
```
source activate /workspace/env/miniconda/envs/ffcv && \
conda install nvidia/label/cuda-11.8.0::cuda-toolkit -y && \
conda install pytorch==2.0.0 torchvision==0.15.0 pytorch-cuda=11.8 -c pytorch -c nvidia -y 
```
