#!/bin/sh

cd ~
mkdir repos -p
cd repos
git clone https://github.com/BVLC/caffe.git
cd caffe
#Stable version cuDNN4
git checkout rc3 
#Unstable version -> cuDNN5
#git checkout e79bc8f1f6df4db3a293ef057b7ca5299c01074a

cp Makefile.config.example Makefile.config
sed -i 's/# USE_CUDNN := 1/USE_CUDNN := 1/' Makefile.config
sed -i 's/# OPENCV_VERSION := 3/OPENCV_VERSION := 3/' Makefile.config

sudo apt-get --assume-yes install libhdf5-dev
sudo apt-get --assume-yes install python-skimage
sudo pip install -r python/requirements.txt
sudo apt-get --assume-yes install libprotobuf-dev libgoogle-glog-dev libgflags-dev protobuf-compiler liblmdb-dev


echo "export PYTHONPATH=/home/ubuntu/repos/caffe/python" >> ~/.bashrc
echo "export CAFFE_ROOT=/home/ubuntu/repos/caffe" >> ~/.bashrc
source ~/.bashrc


make all -j $(($(nproc) + 1))
make test -j $(($(nproc) + 1))
make runtest -j $(($(nproc) + 1))
#Check all test are passed before continue

make pycaffe -j $(($(nproc) + 1))

# A nice test for pycaffe could be done like this:
# python
# import caffe