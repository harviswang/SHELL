#!/bin/sh

# Get the dir of this script
# Make sure C/CPP/JAVA/QT/onedriveroneweek at the same dir of SHELL
PWD=$(cd "$(dirname "$0")"; pwd)
LOCAL_PATH=$PWD/../../../

# Update C git
cd $LOCAL_PATH/C/
git pull

# Update CPP git
cd $LOCAL_PATH/CPP/
git pull

# Update QT git
cd $LOCAL_PATH/QT/
git pull

# Update JAVA git
cd $LOCAL_PATH/JAVA/
git pull

# Update onedriveroneweek git
cd $LOCAL_PATH/onedriveroneweek/
git pull

# Update SHELL git
cd $LOCAL_PATH/SHELL/
git pull
