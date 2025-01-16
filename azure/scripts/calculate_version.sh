#!/bin/bash

echo "#######################################"
echo "#              INPUT                  #"
echo "#######################################"
echo "ProjectPath: $PROJECT_PATH"
echo "Increment: $INCREMENT"
echo "Release: $RELEASE"
echo "Suffix: $SUFFIX"
echo "#######################################"

echo "#######################################"
echo "#            CALCULATING              #"
echo "#######################################"

if [[ $PROJECT_PATH == *.csproj ]]; then
  echo "The Project is a .csproj"
  echo "Reading last version from .csproj"
  
  last_version=$(grep -oP '(?<=<Version>).*?(?=</Version>)' $PROJECT_PATH)
  if [[ -z $last_version ]]; then
    last_version="0.0.0"
  fi

  major="$(echo $last_version | cut -d'.' -f1)"
  minor="$(echo $last_version | cut -d'.' -f2)"
  patch="$(echo $last_version | cut -d'.' -f3)"
else
  cd $PROJECT_PATH
  git fetch --tags --prune
  last_tag=$(git describe --tags `git rev-list --tags --max-count=1`)
  
  if [[ -z $last_tag ]]; then
    last_tag="0.0.0"
  fi

  major="$(echo $last_tag | cut -d'.' -f1)"
  minor="$(echo $last_tag | cut -d'.' -f2)"
  patch="$(echo $last_tag | cut -d'.' -f3)"
fi

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

if [[ $SUFFIX != "none" ]]; then
  new_version="$new_version-$SUFFIX.$RELEASE"
fi

echo "Last version: $last_tag"
echo "New version: $new_version"
echo "Major: $major"
echo "Minor: $minor"
echo "Patch: $patch"
echo "#######################################"

echo "##vso[task.setvariable variable=last_version;isOutput=true]$last_version"
echo "##vso[task.setvariable variable=new_version;isOutput=true]$new_version"

exit 0
