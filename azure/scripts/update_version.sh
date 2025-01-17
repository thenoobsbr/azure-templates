#!/bin/bash

echo "#####################"
echo "#       Input       #"
echo "#####################"
echo "UserEmail: $USER_EMAIL"
echo "UserName: $USER_NAME"
echo "ArtifactPath: $ARTIFACT_PATH"
echo "SourcePath: $SOURCE_PATH"
echo "SourceBranch: $SOURCE_BRANCH"
echo "#####################"

echo "#####################"
echo "#   Install tools   #"
echo "#####################"
sudo apt install -y exiftool
dotnet tool install -g dotnet-setversion

echo "#####################"

echo "#####################"
echo "#  Change version   #"
echo "#####################"

for folder in "$ARTIFACT_PATH"/*; do
  if [ ! -d "$folder" ]; then
    continue
  fi
  
  echo "Found artifact: $folder"
  
  project_name=$(basename "$folder")
  echo "Project name: $project_name"

  dll_path=$(find "$folder" -type f -name "$project_name.dll" | head -n 1)
  if [ -z "$dll_path" ]; then
    continue
  fi
  echo "Found DLL: $dll_path"

  version=$(exiftool $dll_path | grep "Product Version  " | awk -F ': ' '{print $2}')
  echo "Version: $version"

  project_path=$(find "$SOURCE_FOLDER" -type f -name "$project_name.csproj" | head -n 1)
  if [ -z "$project_path" ]; then
    continue
  fi
  echo "Found project: $project_path"

  setversion $version $project_path
  echo "Updated project: $project_name.csproj with version: $version"
done

echo "#####################"

echo "#####################"
echo "#      Git push     #"
echo "#####################"

cd $SOURCE_PATH

git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}"
git add . --all
git commit -m ":bookmark: update version"
git push origin HEAD:$SOURCE_BRANCH

echo "#####################"

echo "################"
echo "#     Done     #"
echo "################"

exit 0