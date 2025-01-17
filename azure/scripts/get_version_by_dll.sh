#!/bin/bash

echo "#####################"
echo "#       Input       #"
echo "#####################"
echo "DLL: $DLL_PATH"

echo "#####################"
echo "#    Install tool   #"
echo "#####################"
sudo apt install -y exiftool

echo "#####################"

echo "#####################"
echo "#    Get version    #"
echo "#####################"

version=$(exiftool ${DLL_PATH} | grep "Product Version  " | awk -F ': ' '{print $2}')

echo "Version: $version"
echo "#####################"

echo "##vso[task.setvariable variable=version;isOutput=true]$version"

echo "################"
echo "#     Done     #"
echo "################"

exit 0