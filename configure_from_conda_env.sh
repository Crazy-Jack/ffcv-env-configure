export WORK_DIR=/workspace
export WORK_ENV_DIR=/workspace/env

echo ""
echo "#########################"
echo "#  [1] Backblaze Setup  #"
echo "#########################"
echo ""

cd $WORK_DIR
# Download the environment
wget https://github.com/Backblaze/B2_Command_Line_Tool/releases/latest/download/b2-linux
mv b2-linux b2
chmod +x b2
# authentica the b2
./b2 account authorize 


echo ""
echo "#########################"
echo "#  [2]  Ubuntu Setup    #"
echo "#########################"
echo ""

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


echo ""
echo "#############################"
echo "# [3] Download Environments #"
echo "#############################"
echo ""

# download the ffcv_conda_env.zip
./b2 file download b2://ffcv-env/ffcv_conda_env.zip $WORK_DIR

echo ""
echo "##############################"
echo "# [4] Configure Environments #"
echo "##############################"
echo ""

cd $WORK_DIR
unzip ffcv_conda_env.zip

# init conda
. $WORK_ENV_DIR/miniconda/etc/profile.d/conda.sh
conda init bash
. $HOME/.bashrc 
# activate ffcv
conda activate ffcv 

# env
export LD_LIBRARY_PATH=$CONDA_PREFIX/ffcv/lib:$LD_LIBRARY_PATH

# configure pkg path for opencv and libjpeg-turbo
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/pkgconfig

# configure LD_library
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/

echo ""
echo "#########################"
echo "#   Test Environments   #"
echo "#########################"
echo ""
# To test, we run a simple cifar which should only takes about a few mintes. 
conda activate ffcv 
cd /tmp/
git clone https://github.com/libffcv/ffcv.git && cd /tmp/ffcv/examples/cifar
bash train_cifar.sh
cd /tmp/
rm -rf /tmp/ffcv # clean up
cd $WORK_DIR

echo "#########################"
echo "#        DONE :)        #"
echo "#########################"
