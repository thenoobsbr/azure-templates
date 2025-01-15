#!/bin/bash

echo "#######################################"
echo "#              INPUT                  #"
echo "#######################################"
echo "Increment: $INCREMENT"
echo "Current counter: $CURRENT_COUNTER"
echo "#######################################"

echo "#######################################"
echo "#            LAST VERSION             #"
echo "#######################################"

if [[ $PROJECT_PATH =~ ".csproj" ]];
  last_version=$(grep -oP '(?<=<Version>)[^<]+' $PROJECT_PATH)
then
else
  cd $PROJECT_PATH
  git fetch --tags --prune
  last_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
  major="$(echo $last_tag | cut -d'.' -f1)"
  minor="$(echo $last_tag | cut -d'.' -f2)"
  patch="$(echo $last_tag | cut -d'.' -f3)"
end

echo "Last version: $last_tag"
echo "Major: $major"
echo "Minor: $minor"
echo "Patch: $patch"
echo "#######################################"

echo "#######################################"
echo "#           NEW VERSION               #"
echo "#######################################"

if [[ $INCREMENT == "major" ]]; then
  major=$((major+1))
  minor="0"
  patch="0"
elif [[ $INCREMENT == "minor" ]]; then
  minor=$((minor+1))
  patch="0"
elif [[ $INCREMENT == "patch" ]]; then
  patch=$((patch+1))
fi

new_version="$major.$minor.$patch"

echo "New version: $new_version"
echo "Major: $major"
echo "Minor: $minor"
echo "Patch: $patch"
echo "#######################################"

echo "##vso[task.setvariable variable=version;isOutput=true]$new_version"