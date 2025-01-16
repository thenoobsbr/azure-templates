#!/bin/bash

echo "#####################"
echo "#       Input       #"
echo "#####################"
echo "DLL: $DLL_PATH"

echo "#####################"
echo "#    Install tool   #"
echo "#####################"
sudo apt install -y radare2

echo "#####################"

echo "#####################"
echo "#    Get version    #"
echo "#####################"

version=$(rabin2 -I ${DLL_PATH} | grep version | awk '{print $2}')

echo "Version: $version"
echo "#####################"

echo "##vso[task.setvariable variable=version;isOutput=true]$version"