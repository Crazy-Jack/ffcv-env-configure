wget https://github.com/Backblaze/B2_Command_Line_Tool/releases/latest/download/b2-linux
mv b2-linux b2
chmod +x b2

# authorization

# upload
./b2 file upload ffcv-env ffcv_conda_env.zip ffcv_conda_env.zip