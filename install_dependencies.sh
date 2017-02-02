#!/bin/bash

if [[ `uname` != 'Linux' ]]; then
  echo "Platform unsupported, only available for Linux."
  exit
fi
if [[ `which apt-get` == '' ]]; then
    echo "apt-get not found, platform not supported."
    exit
fi

echo "==> Checking whether Torch7 is already installed."
luarocks --version >> /dev/null
RET=$?; if [ $RET -ne 0 ]; then echo "Error on luarocks. Exiting."; exit $RET; fi
qlua -l cutorch -nographics -e ""
RET=$?; if [ $RET -ne 0 ]; then echo "Error on qlua. Exiting."; exit $RET; fi
echo "Done."

echo "==> Installing additional dependencies."
sudo apt-get install -qqy liblua5.1-0-dev
sudo apt-get install -qqy libgd-dev
sudo apt-get update
echo "Done."

echo "==> Installing Xitari ..."
cd /tmp
rm -rf xitari
git clone https://github.com/deepmind/xitari.git
cd xitari
luarocks make
RET=$?; if [ $RET -ne 0 ]; then echo "Error. Exiting."; exit $RET; fi
echo "Xitari installation completed."

echo "==> Installing Alewrap ..."
cd /tmp
rm -rf alewrap
git clone https://github.com/deepmind/alewrap.git
cd alewrap
luarocks make
RET=$?; if [ $RET -ne 0 ]; then echo "Error. Exiting."; exit $RET; fi
echo "Alewrap installation completed."

echo "==> Installing Lua-GD ..."
cd /tmp
rm -rf lua-gd
git clone https://github.com/ittner/lua-gd.git
cd lua-gd
sed -i "s/LUABIN=lua5.1/LUABIN=luajit/" Makefile
luarocks make
RET=$?; if [ $RET -ne 0 ]; then echo "Error. Exiting."; exit $RET; fi
echo "Lua-GD installation completed."

