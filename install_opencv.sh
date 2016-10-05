#!/bin/sh

CORES=nproc

sudo apt-get --assume-yes install build-essential cmake git pkg-config
sudo apt-get --assume-yes install libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev
sudo apt-get --assume-yes install libgtk2.0-dev
sudo apt-get --assume-yes install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get --assume-yes install libatlas-base-dev gfortran

# Not needed if called from install_caffe_dependencies.sh
#wget https://bootstrap.pypa.io/get-pip.py
#sudo python get-pip.py


cd ~
mkdir repos -p
cd repos
git clone https://github.com/Itseez/opencv.git
cd opencv
git checkout 3.1.0

# El fallo que me daba siempre es este, se me olvidaba copiar este repo xD
cd ~/repos
git clone https://github.com/Itseez/opencv_contrib.git
cd opencv_contrib
git checkout 3.1.0


#Setup
cd ~/repos/opencv
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=ON \
	-D OPENCV_EXTRA_MODULES_PATH=~/repos/opencv_contrib/modules \
	-D BUILD_EXAMPLES=ON ..

# This line
# -D INSTALL_C_EXAMPLES=OFF \ 
# should be ON, but there is a known bug and turning this OFF avoids it

make -j$CORES

sudo make install
sudo ldconfig


# For test
#python
#import cv2

