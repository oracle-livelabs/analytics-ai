#!/bin/bash
# Copyright (c) 2019-2022 Oracle and/or its affiliates. All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl.

print-options() {
    echo "
Usage:

find-and-replace-string-in-file
  --find=\"string to find\"
  --replace-with=\"string to use as replacement\"
  --file=\"the file which contains the string to replace\"
"
}

for i in "$@"; do
  case $i in
    --find=*)
      find="${i#*=}"
      shift
      ;;
    --replace-with=*)
      replace_with="${i#*=}"
      shift
      ;;
   --file=*)
      file="${i#*=}"
      shift
      ;;
    -*|--*)
      echo $i
      print-options
      exit 1
      ;;
    *)
      ;;
  esac
done

if [[ "$find" == "" || "$replace_with" == "" || "$file" == "" ]]; then
    print-options
    exit 2
fi

sed -i'' -e "s|$find|$replace_with|" $file