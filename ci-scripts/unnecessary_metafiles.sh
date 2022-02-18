#!/bin/bash

if [ ! "$BASH_VERSION" ] ; then
    echo "Please use bash instead of sh to run this script"
    exit 1
fi

echo "Detect unnecessary Metafiles:"
rm -f "/tmp/unnecessary_metafiles.log"

du -a 'Platform/Assets/' | \
#Read only the filepart
grep -oP 'Platform/Assets/.+$' | \
#Filter out existing metafiles
grep -P '^.*\.meta$' | \
#iterate over list
while read -r file 
do
  # check if there is no metafile
  original="$(dirname "$file")/$(basename "$file" ".meta")"

  if [[ ! -e $original ]]
  then
    echo "Unnecessary Metafile $file,"
    echo "Unnecessary Metafile: $file" >> "/tmp/unnecessary_metafiles.log"
  fi
done

if [[ -f "/tmp/unnecessary_metafiles.log" ]] ; then
  echo "Unnecessary Metafiles found"
  exit 1
fi

echo "Metafile check successfull"