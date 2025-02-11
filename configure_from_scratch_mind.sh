#!/bin/bash 

echo "######### [0 / 14] Configure necessary linux packages ######### "
# apt-get update && apt-get install -y --no-install-recommends \
#     software-properties-common   \
#     build-essential  \
#     curl  \
#     git \
#     vim  \
#     ffmpeg  \
#     tmux  \
#     cmake  \
#     g++ wget unzip zip \
#     pkg-config

export WORK_DIR=/lab_data/leelab/tianqinl/ffcv-env
export WORK_ENV_DIR=/lab_data/leelab/tianqinl/ffcv-env/env

echo "######### [1 / 14] Configure WORK_ENV_DIR to be $WORK_ENV_DIR ######### "
mkdir -p $WORK_ENV_DIR
# copy current asset to WORK_ENV_DIR
cp ./torchmetrics-0.6.0.tar.gz $WORK_ENV_DIR

echo "######### [2 / 14] Install conda ######### "
# Install conda but the vast ai already has it. 
# cd /tmp/
# curl -LO https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# bash Miniconda3-latest-Linux-x86_64.sh -b -u -p $WORK_ENV_DIR/miniconda
# cd $WORK_ENV_DIR
# # makesure use the right conda
# source $WORK_ENV_DIR/miniconda/etc/profile.d/conda.sh
# conda init bash
# source $HOME/.bashrc 

echo "######### [3 / 14] Create ffcv conda env ######### "
# create conda env 
conda create -n ffcv python=3.9 -y
conda activate ffcv 
# confirm conda prefix 
echo $CONDA_PREFIX # workspace/env/miniconda/envs/ffcv

echo "######### [4 / 14] Install cudatoolkit and cudnn on conda #########"
conda install -c conda-forge cudatoolkit=11.8 cudnn=8.2 -y
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH

echo "######### [5 / 14] Install torch related pkg #########"
# install torch
pip3 install torch==2.2.2 torchvision==0.17.2 torchaudio==2.2.2 --index-url https://download.pytorch.org/whl/cu118


echo "######### [6 / 14] Install cupy-cuda #########"
pip3 install cupy-cuda11x

echo "######### [7 / 14] Install numba #########"
pip3 install numba


echo "######### [8 / 14] Compile OpenCV from source #########"

# compile Cmake from source : install cmake 3.12 (require install cmake 3.7 >+)
# https://gist.github.com/crazytaxii/483b6c2ff69aa259050e14d512d3582b

cd $WORK_DIR
wget https://cmake.org/files/v3.12/cmake-3.12.3.tar.gz
tar -xvzf cmake-3.12.3.tar.gz
cd cmake-3.12.3
./configure --prefix=$WORK_DIR/cmake_install
make -j8
make install

export PATH=$WORK_DIR/cmake_install/bin:$PATH # it is superimportant to put $WORK_DIR/cmake_install/bin before $PATH so that the new installed cmake-3.12 can overwrites the previous one
export CMAKE_ROOT=$WORK_DIR/cmake_install/share/cmake-3.12


module load gcc-6.3.0 # important for passing through opencv compilation

cd $WORK_ENV_DIR
mkdir -p $WORK_ENV_DIR/Install-OpenCV && cd $WORK_ENV_DIR/Install-OpenCV
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip
unzip opencv.zip
mv opencv-4.x opencv && cd opencv 
mkdir -p build && cd build
# configure with CMAKE -- make sure to activate ffcv conda
conda activate ffcv
cmake -DCMAKE_CXX_STANDARD=17 -DWITH_IPP=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=$WORK_ENV_DIR/Install-OpenCV/source/ -D OPENCV_GENERATE_PKGCONFIG=ON -D BUILD_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D INSTALL_C_EXAMPLES=OFF -D PYTHON3_EXECUTABLE=$CONDA_PREFIX/bin/python3 -D OPENCV_GENERATE_PKGCONFIG=ON -D PYTHON3_INCLUDE_DIR=$($CONDA_PREFIX/bin/python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") -D PYTHON3_PACKAGES_PATH=$($CONDA_PREFIX/bin/python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") ..
# make & install 
make -j8
make install
# configure ENV variables
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib64/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib64
cd $WORK_ENV_DIR

echo "######### [9 / 14] Compile Libjpeg-turbo from source #########"

mkdir -p $WORK_ENV_DIR/Install-libjpeg-turbo/ && cd $WORK_ENV_DIR/Install-libjpeg-turbo/
wget https://github.com/libjpeg-turbo/libjpeg-turbo/archive/refs/heads/main.zip
unzip main.zip 
mv libjpeg-turbo-main libjpeg-turbo
cd $WORK_ENV_DIR/Install-libjpeg-turbo/libjpeg-turbo

mkdir -p build && cd build
cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=$WORK_ENV_DIR/Install-libjpeg-turbo/install/ ..
make -j8
make install
# configure ENV variables
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib64/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib64/
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


# permentately added 
echo 'export WORK_DIR=/lab_data/leelab/tianqinl/ffcv-env' >> ~/.bashrc
echo 'export WORK_ENV_DIR=/lab_data/leelab/tianqinl/ffcv-env/env' >> ~/.bashrc
echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib64/pkgconfig' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib64/' >> ~/.bashrc
echo 'export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib64/pkgconfig' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib64' >> ~/.bashrc



echo "######### Done! Have a nice ffcv acceleration day ~! #########"
