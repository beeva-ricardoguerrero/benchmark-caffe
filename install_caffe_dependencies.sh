#!/bin/sh


#UPDATE
sudo apt-get --assume-yes update
sudo apt-get --assume-yes upgrade

#Useful staff
#Git, scipy stack, etc

sudo apt-get --assume-yes install make
sudo apt-get --assume-yes install g++
sudo apt-get --assume-yes install git
sudo apt-get --assume-yes install spyder
sudo apt-get --assume-yes install python-pip
sudo pip install virtualenv
sudo apt-get --assume-yes install python-skimage
sudo apt-get --assume-yes install wget
sudo apt-get --assume-yes install libprotobuf-dev libgoogle-glog-dev libgflags-dev protobuf-compiler
sudo apt-get --assume-yes install libhdf5-serial-dev


#Install Caffe pre-requisites
#BLAS, BOOST, OPENCV, lmdb, leveldb (note: leveldb requires snappy)

#Seems that spyder install openblas. Let's assume it is. In case of error, check this !!!!!

sudo apt-get --assume-yes install libboost-all-dev

./install_leveldb.sh

./install_opencv.sh

#Install Nvidia driver (GRID K520) Unfortunately, this part needs user interaction
sudo apt-get --assume-yes install linux-image-extra-virtual
sudo apt-get --assume-yes install linux-source
sudo apt-get --assume-yes install linux-headers-`uname -r`


echo -e "blacklist nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo -e "blacklist lbm-nouveau" >> /etc/modprobe.d/blacklist-nouveau.conf
echo -e "options nouveau modeset=0" >> /etc/modprobe.d/blacklist-nouveau.conf
echo -e "alias nouveau off" >> /etc/modprobe.d/blacklist-nouveau.conf
echo -e "alias lbm-nouveau off" >> /etc/modprobe.d/blacklist-nouveau.conf

sudo echo options nouveau modeset=0 | sudo tee -a /etc/modprobe.d/nouveau-kms.conf
sudo update-initramfs -u
sudo reboot

#wget http://es.download.nvidia.com/XFree86/Linux-x86_64/361.45.11/NVIDIA-Linux-x86_64-361.45.11.run
#chmod +x NVIDIA-Linux-x86_64-361.45.11.run
#sudo ./NVIDIA-Linux-x86_64-361.45.11.run

wget http://es.download.nvidia.com/XFree86/Linux-x86_64/352.63/NVIDIA-Linux-x86_64-352.63.run
chmod +x NVIDIA-Linux-x86_64-352.63.run
sudo sh NVIDIA-Linux-x86_64-352.63.run
sudo modprobe nvidia

#Install CUDA 7.5 (compatible with CuDNN4 and CuDNN5)
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1404-7-5-local_7.5-18_amd64.deb
sudo apt-get update
sudo apt-get --assume-yes install cuda

echo 'export PATH=/usr/local/cuda/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc

#Install CuDNN (this part is variable in the experiments, hence, this will be commented to avoid unwanted executions. However, this process will be included here)

#CuDNN4
cd cudnn_downloaded_files 
tar -xzf cudnn-7.0-linux-x64-v4.0-prod.tgz
cd cuda
sudo cp */*.h /usr/local/cuda/include/
sudo cp */*.so* /usr/local/cuda/lib64/
sudo ldconfig

#CuDNN5
#cd cudnn_downloaded_files 
#tar -xzf cudnn-7.5-linux-x64-v5.0-ga.tgz
#cd cuda
#sudo cp */*.h /usr/local/cuda/include/
#sudo cp */*.so* /usr/local/cuda/lib64/
#sudo ldconfig

sudo sh -c "echo '/usr/local/cuda/lib64' > /etc/ld.so.conf.d/cuda.conf"
sudo ldconfig
