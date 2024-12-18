#/!bin/bash

export VERSION_MAJOR="$(echo $LAST_TAG | cut -d'.' -f1)"
export VERSION_MINOR="$(echo $LAST_TAG | cut -d'.' -f2)"
export VERSION_PATCH="$(echo $LAST_TAG | cut -d'.' -f3)"

VERSION_MAJOR=${VERSION_MAJOR:="1"}
VERSION_MINOR=${VERSION_MINOR:="0"}
VERSION_PATCH=${VERSION_PATCH:="0"}

echo "#######################################"
echo "#              INPUT                   "
echo "#######################################"
echo "VersionMessage: $SOURCE_VERSION_MESSAGE"
echo "Branch: $SOURCE_BRANCH"
if [[ ! -z "$PR_SOURCE_BRANCH" ]] &&
    ! [[ $PR_SOURCE_BRANCH =~ "PullRequest" ]];
then
    echo "PR Branch: $PR_SOURCE_BRANCH"
    export SOURCE_BRANCH="$PR_SOURCE_BRANCH";
fi
echo "CurrentCounter: $CURRENT_COUNTER"
echo "Reason: $REASON"
echo "LastTag: $LAST_TAG"
echo "Version.Major: $VERSION_MAJOR"
echo "Version.Minor: $VERSION_MINOR"
echo "Version.Patch: $VERSION_PATCH"
echo "#######################################"

if [[ $SOURCE_BRANCH =~ "/tags/" ]];
then
    export VERSION="$(echo $SOURCE_BRANCH | cut -d'/' -f3)"
    
    echo "#######################################"
    echo "#          TAG $VERSION"
    echo "#######################################"
    
    echo "##vso[task.setvariable variable=version;isOutput=true]$VERSION"
    echo "##vso[task.setvariable variable=staging_deploy;isOutput=true]True"
    echo "##vso[task.setvariable variable=production_deploy;isOutput=true]True"
    echo "##vso[build.updatebuildnumber]$VERSION"
    
    echo "#######################################"
    echo "#             OUTPUT                  #"
    echo "#######################################"
    echo "Version: $VERSION"
    echo "Staging deploy: TRUE                  #"
    echo "Production deploy: TRUE               #"
    echo "#######################################"
    
    exit 0
fi

if [[ $SOURCE_BRANCH =~ (refs/heads/)?(.*) ]]; then
	export SOURCE_BRANCH="/${BASH_REMATCH[2]}"
fi

if [[ $SOURCE_BRANCH =~ "/feature/" ]];
then
    echo "#######################################"
    echo "#              FEATURE                #"
    echo "#######################################"

    VERSION_MINOR=$((VERSION_MINOR+1))
    
    export VERSION_PREFIX="$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"
    export VERSION_SUFFIX="alpha.${CURRENT_COUNTER}"
    export VERSION="$VERSION_PREFIX-$VERSION_SUFFIX"
    
    echo "##vso[task.setvariable variable=version;isOutput=true]$VERSION"
    echo "##vso[task.setvariable variable=staging_deploy;isOutput=true]False"
    echo "##vso[task.setvariable variable=production_deploy;isOutput=true]False"
    echo "##vso[build.updatebuildnumber]$VERSION"
    
    echo "#######################################"
    echo "#             OUTPUT                  #"
    echo "#######################################"
    echo "Version: $VERSION"
    echo "Staging deploy: FALSE                 #"
    echo "Production deploy: FALSE              #"
    echo "#######################################"
    
    exit 0
fi

if [[ $SOURCE_BRANCH =~ "/bugfix/" ]];
then
    echo "#######################################"
    echo "#               BUGFIX                #"
    echo "#######################################"

    VERSION_PATCH=$((VERSION_PATCH+1))
    
    export VERSION_PREFIX="$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"
    export VERSION_SUFFIX="beta.${CURRENT_COUNTER}"
    export VERSION="$VERSION_PREFIX-$VERSION_SUFFIX"
    
    echo "##vso[task.setvariable variable=version;isOutput=true]$VERSION"
    echo "##vso[task.setvariable variable=staging_deploy;isOutput=true]False"
    echo "##vso[task.setvariable variable=production_deploy;isOutput=true]False"
    echo "##vso[build.updatebuildnumber]$VERSION"
    
    echo "#######################################"
    echo "#             OUTPUT                  #"
    echo "#######################################"
    echo "# Version: $VERSION"
    echo "# Staging deploy: FALSE               #"
    echo "# Production deploy: FALSE            #"
    echo "#######################################"
    
    exit 0
fi

if [[ $SOURCE_BRANCH =~ "/hotfix/" ]] ||
    [[ $SOURCE_BRANCH =~ "/release/" ]];
then
    echo "#######################################"
    echo "#           HOTFIX / RELEASE          #"
    echo "#######################################"

    export VERSION="$(echo $SOURCE_BRANCH | cut -d'/' -f3)"
    export VERSION_MAJOR="$(echo $VERSION | cut -d'.' -f1)"
    export VERSION_MINOR="$(echo $VERSION | cut -d'.' -f2)"
    export VERSION_PATCH="$(echo $VERSION | cut -d'.' -f3)"

    export VERSION_PREFIX="$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"
    export VERSION_SUFFIX="rc.${CURRENT_COUNTER}"
    export VERSION="$VERSION_PREFIX-$VERSION_SUFFIX"
    
    echo "##vso[task.setvariable variable=version;isOutput=true]$VERSION"
    echo "##vso[task.setvariable variable=staging_deploy;isOutput=true]True"
    echo "##vso[task.setvariable variable=production_deploy;isOutput=true]False"
    echo "##vso[build.updatebuildnumber]$VERSION"
    
    echo "#######################################"
    echo "#               OUTPUT                #"
    echo "#######################################"
    echo "Version: $VERSION"
    echo "Staging deploy: TRUE                  #"
    echo "Production deploy: FALSE              #"
    echo "#######################################"
    
    exit 0
fi

echo "#######################################"
echo "#              OTHERS                 #"
echo "#######################################"

export VERSION_PREFIX="$VERSION_MAJOR.$VERSION_MINOR.$VERSION_PATCH"
export VERSION_SUFFIX="ci.${CURRENT_COUNTER}"
export VERSION="$VERSION_PREFIX-$VERSION_SUFFIX"

echo "##vso[task.setvariable variable=version;isOutput=true]$VERSION"
echo "##vso[task.setvariable variable=staging_deploy;isOutput=true]False"
echo "##vso[task.setvariable variable=production_deploy;isOutput=true]False"
echo "##vso[build.updatebuildnumber]$VERSION"

echo "#######################################"
echo "#               OUTPUT                #"
echo "#######################################"
echo "Version: $VERSION"
echo "Staging deploy: FALSE                  #"
echo "Production deploy: FALSE              #"
echo "#######################################"

exit 0