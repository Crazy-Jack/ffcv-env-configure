echo "[] Configure PATH for PKG and LD_LIBRARY_PATH"
export WORKDIR=/workspace/env
conda activate ffcv 
# configure cuda path
export LD_LIBRARY_PATH=$CONDA_PREFIX/ffcv/lib:$LD_LIBRARY_PATH

# configure pkg path for opencv and libjpeg-turbo
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORKDIR/Install-OpenCV/source/lib/pkgconfig
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:$WORKDIR/Install-libjpeg-turbo/install/lib/pkgconfig

# configure LD_library
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKDIR/Install-OpenCV/source/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$WORKDIR/Install-libjpeg-turbo/install/lib/
