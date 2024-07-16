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
bash $WORK_ENV_DIR/miniconda/etc/profile.d/conda.sh && \
conda init bash && \
source $HOME/.bashrc && \
source activate /workspace/env/miniconda/envs/ffcv

# env
export LD_LIBRARY_PATH=$CONDA_PREFIX/ffcv/lib

# configure pkg path for opencv and libjpeg-turbo
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/pkgconfig

# configure LD_library
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-OpenCV/source/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORK_ENV_DIR/Install-libjpeg-turbo/install/lib/

# install ffcv ssl 
source activate /workspace/env/miniconda/envs/ffcv && cd $WORK_ENV_DIR && \
git clone https://github.com/facebookresearch/FFCV-SSL.git && \
cd FFCV-SSL && pip install -e . 

# install timm
source activate /workspace/env/miniconda/envs/ffcv && cd $WORK_ENV_DIR && \
git clone https://github.com/huggingface/pytorch-image-models.git && \
cd pytorch-image-models && git checkout v0.4.12 && pip install -e . 

echo ""
echo "#########################"
echo "#   Test Environments   #"
echo "#########################"
echo ""
# To test, we run a simple cifar which should only takes about a few mintes. 
source activate ffcv 
cd /tmp/
git clone https://github.com/libffcv/ffcv.git && cd /tmp/ffcv/examples/cifar
bash train_cifar.sh
cd /tmp/
rm -rf /tmp/ffcv # clean up
cd $WORK_DIR


echo "#########################"
echo "#        Dataset :)     #"
echo "#########################"
mkdir -p /workspace/data/ffcv-imagenet
/workspace/b2 file download b2://ffcv-imagenet/in1k_train_500_0.50_90.ffcv /workspace/data/ffcv-imagenet/train_500_0.50_90.ffcv


# cuda11.8
source activate /workspace/env/miniconda/envs/ffcv && \
conda install nvidia/label/cuda-11.8.0::cuda-toolkit -y && \
conda install pytorch==2.0.0 torchvision==0.15.0 pytorch-cuda=11.8 -c pytorch -c nvidia -y 

# ffcv
source activate /workspace/env/miniconda/envs/ffcv && \
pip uninstall ffcv -y && \
pip install /workspace/env/FFCV-SSL


echo "#########################"
echo "#        DONE :)        #"
echo "#########################"
