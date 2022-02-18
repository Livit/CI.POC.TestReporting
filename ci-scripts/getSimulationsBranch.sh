#!/bin/sh

allPlatformBranch="simulation/ALL/platform";
allPlatformMinorBranch="simulation/ALL/platform-minor";
base_ref="123";
branch=$allPlatformMinorBranch;
if [[ -z "${base_ref}" ]]
then
:

elif [[ "${base_ref}" -ne "develop" ]] && [[ "${base_ref}" -ne "master" ]]
then
    # minimalVerson = "6.5.1"
    # elements = "${base_ref}" -split "/" | Select-Object -Last 1
    # version = ($elements -split "\D+" -join ".")

    # if (!("${base_ref}".Contains("feature/"))) 
    # then
    #     if ($version -lt $minimalVerson) 
    #     then
    #         allPlatformBranch="simulation/ALL/platform-2020-10-old-ph"
    #         allPlatformMinorBranch="simulation/ALL/platform-minor-2020-10-old-ph"
    #     fi
    # fi

    # branch=$allPlatformMinorBranch
    
    if [[ "${base_ref}" =~ ".*release\/.*\.0" ]]
    then
        branch=$allPlatformBranch;
    fi;
elif [[ "${base_ref}" -eq "develop" ]] 
then
    branch=$allPlatformBranch
fi;

echo $branch