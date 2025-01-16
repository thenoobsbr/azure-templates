#!/bin/bash

echo "#####################"
echo "#       Input       #"
echo "#####################"
echo "UserEmail: $USER_EMAIL"
echo "UserName: $USER_NAME"
echo "SourcePath: $SOURCE_PATH"
echo "SourceBranch: $SOURCE_BRANCH"
echo "ProjectPath: $PROJECT_PATH"
echo "Version: $VERSION"
echo "#####################"

echo "#####################"
echo "#    Install tool   #"
echo "#####################"
dotnet tool install -g dotnet-setversion

echo "#####################"

echo "#####################"
echo "#  Change version   #"
echo "#####################"

setversion $VERSION $PROJECT_PATH

echo "#####################"

echo "#####################"
echo "#      Git push     #"
echo "#####################"

cd $SOURCE_PATH

git config --global user.email "${USER_EMAIL}"
git config --global user.name "${USER_NAME}"
git add .
git commit -m ":bookmark: update version"
git push origin $SOURCE_BRANCH

echo "#####################"