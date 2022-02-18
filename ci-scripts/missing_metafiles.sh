#!/bin/bash

if [ ! "$BASH_VERSION" ] ; then
    echo "Please use bash instead of sh to run this script"
    exit 1
fi

echo "Detect Missing Metafiles:"
rm -f "/tmp/missing_metafiles.log"

du -a 'Platform/Assets/' | \
#Read only the filepart
grep -oP 'Platform/Assets/.+$' | \
#Filter out existing metafiles
grep -vP '^.*\.meta$' | \
#iterate over list
while read -r file 
do
  # check if there is no metafile
  if [[ ! -f "$file.meta" ]] ; then
      if ! $(echo "$file" | grep -qP "^(Platform/Assets/.*~(/.*)*)|(Platform/Assets/.*/\..+)$" )
      then
        echo "Missing Metafile for: $file"
        echo "Missing Metafile for: $file" >> "/tmp/missing_metafiles.log"
      fi
    fi
done

if [[ -f "/tmp/missing_metafiles.log" ]] ; then
  echo "Missing Metafiles found"
  exit 1
else
  echo "Metafile check successfull"
fi