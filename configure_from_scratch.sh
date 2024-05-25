#!/bin/bash 

echo "######### [0 / 14] Configure necessary linux packages ######### "
apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common   \
    build-essential  \
    curl  \
    git \
    vim  \
    ffmpeg  \
    tmux  \
    cmake  \
    g++ wget unzip zip \
    pkg-config

export WORK_DIR=/workspace
export WORK_ENV_DIR=/workspace/env

echo "######### [1 / 14] Configure WORK_ENV_DIR to be $WORK_ENV_DIR ######### "
mkdir -p $WORK_ENV_DIR
# copy current asset to WORK_ENV_DIR
cp ./torchmetrics-0.6.0.tar.gz $WORK_ENV_DIR

echo "######### [2 / 14] Install conda ######### "
# Install conda but the vast ai already has it. 
cd /tmp/
curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -u -p $WORK_ENV_DIR/miniconda
cd $WORK_ENV_DIR
# makesure use the right conda
source $WORK_ENV_DIR/miniconda/etc/profile.d/conda.sh
conda init bash
source $HOME/.bashrc 

echo "######### [3 / 14] Create ffcv conda env ######### "
# create conda env 
conda create -n ffcv python=3.9 -y
conda activate ffcv 
# confirm conda prefix 
echo $CONDA_PREFIX # workspace/env/miniconda/envs/ffcv

echo "######### [4 / 14] Install cudatoolkit and cudnn on conda #########"
conda install -c conda-forge cudatoolkit=11.8 cudnn=8.2 -y
export LD_LIBRARY_PATH=$CONDA_PREFIX/ffcv/lib:$LD_LIBRARY_PATH

echo "######### [5 / 14] Install torch related pkg #########"
# install torch
pip3 install torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cu118


echo "######### [6 / 14] Install cupy-cuda #########"
pip3 install cupy-cuda11x

echo "######### [7 / 14] Install numba #########"
pip3 install numba


echo "######### [8 / 14] Compile OpenCV from source #########"

cd $WORK_ENV_DIR
mkdir -p $WORK_ENV_DIR/Install-OpenCV && cd $WORK_ENV_DIR/Install-OpenCV
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip
unzip opencv.zip
mv opencv-4.x opencv && cd opencv 
mkdir -p build && cd build
# configure with CMAKE -- make sure to activate ffcv conda
conda activate ffcv
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$WORK_ENV_DIR/Install-OpenCV/source/ -D OPENCV_GENERATE_PKGCONFIG=ON -D BUILD_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D INSTALL_C_EXAMPLES=OFF -D PYTHON_EXECUTABLE=$(which python2) -D BUILD_opencv_python2=OFF -D PYTHON3_EXECUTABLE=$(which python3) -D OPENCV_GENERATE_PKGCONFIG=ON -D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") ..
# make & install 
make -j8
make install
# configure ENV variables
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib
cd $WORK_ENV_DIR

echo "######### [9 / 14] Compile Libjpeg-turbo from source #########"

mkdir -p $WORK_ENV_DIR/Install-libjpeg-turbo/ && cd $WORK_ENV_DIR/Install-libjpeg-turbo/
wget https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/heads/main.zip
unzip main.zip 
mv libjpeg-turbo-main libjpeg-turbo
cd $WORK_ENV_DIR/Install-libjpeg-turbo/libjpeg-turbo

mkdir -p build && cd build
cmake -DCMAKE_INSTALL_PREFIX=$WORK_ENV_DIR/Install-libjpeg-turbo/install/ ..
make -j8
make install
# configure ENV variables
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/
cd $WORK_ENV_DIR

echo "######### [10 / 14] Install FFCV !!!!! #########"
pip3 install ffcv

echo "######### [11 / 14] Install torchmetrics #########"
cd $WORK_ENV_DIR
pip3 install torchmetrics-0.6.0.tar.gz 

echo "######### [12 / 14] Install yaml #########"
pip3 install pyyaml

echo "######### [13 / 14] Install matplotlib #########"
pip3 install matplotlib

echo "######### [14 / 14] Test FFCV is installed #########"
# To test, we run a simple cifar which should only takes about a few mintes. 
cd /tmp/
git clone https://github.com/libffcv/ffcv.git && cd /tmp/ffcv/examples/cifar
bash train_cifar.sh
cd /tmp/
rm -rf /tmp/ffcv # clean up
cd $WORK_DIR

echo "######### Done! Have a nice ffcv acceleration day ~! #########"