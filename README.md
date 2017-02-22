# DeepMind Atari Deep Q Learner

[2017-02-22 update] I used cudnn to speed up training of the DQN. On Jetson TX1, I was able to reduce training time by roughly 1/3 by changing only a few lines of code. Please refer to my blog post, [Using cuDNN to Speed Up DQN Training on Jetson TX1](https://jkjung-avt.github.io/dqn-cudnn/), for more details.

This repository was forked from [kuz's](https://github.com/kuz/DeepMind-Atari-Deep-Q-Learner). I made a few changes to the code so that it could run on NVIDIA's Jetson TX1 platform.

After training the Deep Q Learner on Jetson TX1 for roughly a week, the AI agent could play the 'pong' game like this:

![pong-test](https://github.com/jkjung-avt/DeepMind-Atari-Deep-Q-Learner/blob/master/gifs/pong-test.gif?raw=true)

For more information about what part of the code I've modified, please check out [my blog post](https://jkjung-avt.github.io/). Otherwise, please refer to [kuz's orginal repository](https://github.com/kuz/DeepMind-Atari-Deep-Q-Learner) for more background information about Deep Q Learning and DeepMind's Atari DQN implementation.

Installation Instructions
-------------------------

The installation requires Linux with apt-get. It also **requires Torch7 with CUDA pre-installed** on the system, for which you can refer to ["How to Install Torch7 on Jetson TX1"](https://jkjung-avt.github.io/torch7-on-tx1/) or [the official Torch7 installation guide](http://torch.ch/docs/getting-started.html).

Although I have only mainly tested this Atari DQN on Jetson TX1 with NVIDIA CUDA 8.0, I think it should work on any Linux platform with a recent version of Torch7 and CUDA.

The included installation script would install the following luarocks packages:

* xitari
* alewrap
* luagd (for saving test episodes into gifs)

All you need to do is to run the script.

```shell
 $ ./install_dependencies.sh
```

Training DQN on Atari Games
---------------------------

There already are 2 Atari game ROM files, pong.bin and breakout.bin, in the 'roms' subdirectory. So if you'd like to train the DQN with the 'pong' game, you could just execute the following:

```shell
 $ ./run_gpu pong
```

You can train the DQN for additional games by copying the corresponding ROM files into the same subdirectory. And you'd replace 'pong' with the name of the game, e.g. 'breakout', in the shell command above.

Saving a .gif for a Trained Network
-----------------------------------

Once you have a snapshot (dqn/*.t7) of the trained network, you can run for example:

```shell
 $ ./test_gpu pong
```

