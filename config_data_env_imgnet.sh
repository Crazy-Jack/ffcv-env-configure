export WORK_DIR=/workspace
export WORK_ENV_DIR=/workspace/env

echo ""
echo "#########################"
echo "#  [1] Backblaze Setup  #"
echo "#########################"
echo ""


cd $WORK_DIR
# # Download the environment
# wget https://github.com/Backblaze/B2_Command_Line_Tool/releases/latest/download/b2-linux
# mv b2-linux b2
# chmod +x b2
# # authentica the b2
# ./b2 account authorize 


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

# download the ffcv.tar.gz
/workspace/b2 file download b2://ffcv-env/ffcv_conda_env_2.zip $WORK_DIR/ffcv_conda_env_2.zip

echo ""
echo "##############################"
echo "# [4] Configure Environments #"
echo "##############################"
echo ""

cd $WORK_DIR
# Unpack environment into directory `my_env`
unzip ffcv_conda_env_2.zip


# Activate the environment. This adds `my_env/bin` to your path
conda init bash && \
source $HOME/.bashrc && conda activate $WORK_DIR/env/miniconda/envs/ffcv

# env
export LD_LIBRARY_PATH=$CONDA_PREFIX/ffcv/lib

# configure pkg path for opencv and libjpeg-turbo
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/pkgconfig

# configure LD_library
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/



echo "#########################"
echo "#        Dataset :)     #"
echo "#########################"
mkdir -p /workspace/data/ffcv-data
# small dataset first coco+ade
/workspace/b2 file download b2://ffcv-imagenet/in1k_train_500_0.50_90.ffcv /workspace/data/ffcv-data/in1k_train_500_0.50_90.ffcv

conda init bash && \
source $HOME/.bashrc && conda activate $WORK_DIR/env/miniconda/envs/ffcv && \
$WORK_DIR/env/miniconda/envs/ffcv/bin/pip install slot_attention && \
$WORK_DIR/env/miniconda/envs/ffcv/bin/pip install IPython

git config --global user.email "jacklitianqin@gmail.com"
git config --global user.name "Tianqin Li"


