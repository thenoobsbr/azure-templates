#!/bin/bash

echo "#####################"
echo "#     Input Files   #"
echo "#####################"
echo "Source Path: $SOURCE_PATH"
echo "Destination Path: $DESTINATION_PATH"
echo "#####################"

echo "#################################"
echo "#  Cleaning destination folder  #"
echo "#################################"
rm -rf "$DESTINATION_PATH"
echo "#################################"

echo "######################"
echo "#  Extracting files  #"
echo "######################"

for zipFile in "$SOURCE_PATH"; do
    destinationPath="$DESTINATION_PATH/$(basename "$zipFile" .zip)"
    mkdir -p "$destinationPath"
    unzip "$zipFile" -d "$destinationPath"
done

echo "################"
echo "#     Done     #"
echo "################"

exit 0