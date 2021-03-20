#!/bin/bash
echo "Install the toolchain"
sudo apt-get install libelf-dev linux-headers-$(uname -r) build-essential pkg-config -y

echo "Grab the code"
cd /tmp
wget https://git.zx2c4.com/wireguard-linux-compat/snapshot/wireguard-linux-compat-0.0.20200318.zip
git clone https://git.zx2c4.com/wireguard-tools
unzip wireguard-linux-compat-0.0.20200318.zip
rm wireguard-linux-compat-0.0.20200318.zip
mv wireguard-linux-compat* wireguard-linux-compat

echo "Compile and install the module"
make -C wireguard-linux-compat/src -j$(nproc)
sudo make -C wireguard-linux-compat/src install

echo "Compile and install the wg(8) tool"
make -C wireguard-tools/src -j$(nproc)
sudo make -C wireguard-tools/src install