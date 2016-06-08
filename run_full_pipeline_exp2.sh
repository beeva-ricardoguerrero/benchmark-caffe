#!/bin/sh

HOME_SCRIPTS=$/home/ubuntu/scripts
CUSTOM_SOLVER=HOME_SCRIPTS/experimento/solver.prototxt
FLAG_SOLVERS=-gpu\ all


cd $CAFFE_ROOT

# Download auxiliary data (e.g. mean file, synset words, etc)
#./data/ilsvrc12/get_ilsvrc_aux.sh

# Prepare imagenet (resize images and prepare lmdb files)
$HOME_SCRIPTS/experimento/create_caffenet.sh

# Compute mean of per-channel pixels
$HOME_SCRIPTS/make_caffenet.sh

# Do the training
./build/tools/caffe train --solver=$CUSTOM_SOLVER $FLAG_SOLVERS


