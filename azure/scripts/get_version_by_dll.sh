#!/bin/bash

echo "#####################"
echo "#       Input       #"
echo "#####################"
echo "DLL: $DLL_PATH"

echo "#####################"
echo "#    Install tool   #"
echo "#####################"
sudo apt install -y binutils

echo "#####################"

echo "#####################"
echo "#    Get version    #"
echo "#####################"

version=$(strings ${DLL_PATH} | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

echo "Version: $version"
echo "#####################"

echo "##vso[task.setvariable variable=version;isOutput=true]$version"