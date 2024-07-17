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


# Upload results to pretrain-dense
/workspace/b2 sync --threads 10 /workspace/pretraining-for-dense-tasks/experiments/ b2://pretrain-for-dense-prediction



