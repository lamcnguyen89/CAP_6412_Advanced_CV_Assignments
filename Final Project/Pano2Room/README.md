## Welcome to Pano2Room!

[Pano2Room: Novel View Synthesis from a Single Indoor Panorama (SIGGRAPH Asia 2024)](https://arxiv.org/abs/2408.11413).

## Overview
#### In short, Pano2Room converts an input panorama into 3DGS. 
<img src="demo/Teaser.png" width="100%" >
<img src="demo/Overview.png" width="100%" >



## Demo
In this demo, specify input panorama as:
<img src='demo/input_panorama.png' width="100%" >

Then, Pano2Room generates the corresponding 3DGS and renders novel views:

<img src="demo/GS_render_video.gif" width="40%" >

And the corresponding rendered depth:

<img src="demo/GS_depth_video.gif" width="40%" >

## Quick Run
### 0. Setup the environment
1. Make sure Cuda ToolKit 11.8 is installed. For example in Ubuntu 22.04:

```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.8.0/local_installers/cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2204-11-8-local_11.8.0-520.61.05-1_amd64.deb
sudo cp /var/cuda-repo-ubuntu2204-11-8-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo apt-get update
sudo apt-get -y install cuda

```

2. Add new cuda to your BashRC file:

First open Bashrc file
```
sudo nano ~/.bashrc
```
Next add the lines at the bottom of the file
```
export PATH=/usr/local/cuda-11.8/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-11.8/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```
Then Save and Exit
```
Ctrl +s
Ctrl +x
```

Reboot computer


2. Create a new conda environment. For Example:
```
conda create --name pano2room python=3.9
```
3. Install Pytorch 2.01:

```
conda install pytorch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 pytorch-cuda=11.8 -c pytorch -c nvidia
```
4. Install Pytorch3D [Pytorch3D](https://github.com/facebookresearch/pytorch3d) (for mesh rendering):

```
conda install -c fvcore -c iopath -c conda-forge fvcore iopath
conda install pytorch3d -c pytorch3d
```

5. [diff-gaussian-rasterization-w-depth](https://github.com/JonathonLuiten/diff-gaussian-rasterization-w-depth) (for 3DGS rendering with depth) accordingly. 

```
cd diff-gaussian-rasterization-w-depth
python setup.py install
pip install .
```

6. Finally install Requirements.txt :

```
pip install -r requirements.txt
```

7. Download pretrained weights in \<checkpoints\> (for image inpainting and depth estimation). See \<checkpoints/README.md\> for instructions.

### 1. Run Demo
```
sh scripts/run_Pano2Room.sh
```
This demo converts \<input/input_panorama.png\> to 3DGS and renders novel views as in \<output/Pano2Room-results\>.

### (Optional) 0.5. Fine-tune Inpainter (SDFT)

Before running step 1., you can also fine-tune SD Inpainter model for better inpainting performance for a specific panorama. To do this:

(1) Create self-supervised training pairs:
```
sh scripts/create_SDFT_pairs.sh
```
The pairs are then stored at \<output/SDFT_pseudo_pairs\>.

(2) Training:
```
sh scripts/train_SDFT.sh
```
The SDFT weights are then stored at \<output/SDFT_weights\>.

Then by running step 1., the SDFT weights will be automatically loaded.

Notice this step needs to be performed for each new panorama. If you don't want to train SDFT for a new panorama, delete previous \<output/SDFT_weights\> if exists.

## Try on your own panoramas

You can convert batches of images to 3D models. Just paste them into \<input/Input_Images\> folder

#### Camera Trajectory
We provide a camera trajectory at \<input/Camera_Trajectory\> as in the above demo. Each file consists of [R|T] 4*4 matrix of a frame. Feel free to use more camera trajectories.


## Cite our paper

If you find our work helpful, please cite our paper. Thank you!

ACM Reference Format:
```
Guo Pu, Yiming Zhao, and Zhouhui Lian. 2024. Pano2Room: Novel View Synthesis from a Single Indoor Panorama. In SIGGRAPH Asia 2024 Conference Papers (SA Conference Papers '24), December 3--6, 2024, Tokyo, Japan. ACM, New York, NY, USA, 10 pages.
https://doi.org/10.1145/3680528.3687616
```
