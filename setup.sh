#!/bin/bash

set -x
set -e 
export DEBIAN_FRONTEND=noninteractive

echo 'starting setup'
apt-get --allow-releaseinfo-change update

apt-get -y install build-essential
apt-get -y install cmake
apt-get -y install python3
echo 'installing rust'
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup default stable
apt-get install -y clang
apt-get install -y  python3-pip
apt-get install -y libssl-dev libffi-dev python3-dev cargo
apt-get install -y tmux
rm -rf SailfishTest
echo "cloning repo"
git clone https://github.com/RithwikKerur/SailfishTest.git -b SailfishCFT
cd SailfishTest
pwd
git branch
git log
cd benchmark
pip3 install cryptography
python3 --version
pip3 install -U pip setuptools
pip3 install matplotlib
cat requirements.txt
pip3 install -r requirements.txt --verbose
echo 'finished setup'
