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

major="$(echo $version | cut -d'.' -f1)"
minor="$(echo $version | cut -d'.' -f2)"
patch="$(echo $version | cut -d'.' -f3)"
suffix="$(echo $version | cut -d'-' -f2)"

version_migration="$major.$minor.$patch-migration-${suffix}"

echo "Major: $major"
echo "Minor: $minor"
echo "Patch: $patch"
echo "Suffix: $suffix"
echo "Version: $version"
echo "Migration Version: $version_migration"
echo "#####################"

echo "##vso[task.setvariable variable=version;isOutput=true]$version"
echo "##vso[task.setvariable variable=version_migration;isOutput=true]$version_migration"

echo "################"
echo "#     Done     #"
echo "################"

exit 0