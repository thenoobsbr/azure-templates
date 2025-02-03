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

version=$(exiftool "${DLL_PATH}" | grep "Product Version  " | awk -F ': ' '{print $2}')

# Extrai componentes principais
major=$(echo "$version" | cut -d'.' -f1)
minor=$(echo "$version" | cut -d'.' -f2)
patch_part=$(echo "$version" | cut -d'.' -f3)

# Separa patch e sufixo
patch="${patch_part%%-*}"         # Remove tudo após o primeiro hífen
suffix="${patch_part#$patch}"     # Pega o sufixo (se existir)
suffix="${suffix#-}"              # Remove o hífen inicial do sufixo

# Extrai revisão (se existir)
revision=$(echo "$version" | cut -d'.' -f4)

# Monta a versão de migração
if [ -n "$suffix" ]; then
    # Caso COM sufixo
    version_migration="$major.$minor.$patch-$suffix-migration"
    [ -n "$revision" ] && version_migration="$version_migration.$revision"
else
    # Caso SEM sufixo
    version_migration="$major.$minor.$patch-migration"
    [ -n "$revision" ] && version_migration="$version_migration.$revision"
fi

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