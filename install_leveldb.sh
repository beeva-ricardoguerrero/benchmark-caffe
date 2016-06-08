#!/bin/sh

apt-get --assume-yes install libsnappy-dev

wget https://github.com/google/leveldb/archive/v1.18.tar.gz
tar -xzf v1.18.tar.gz
cd leveldb-1.18
make
sudo mv libleveldb.* /usr/local/lib
cd include
sudo cp -R leveldb /usr/local/include
sudo ldconfig