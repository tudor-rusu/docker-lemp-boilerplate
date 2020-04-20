#!/usr/bin/env bash
# Functions repository
set -e

# global vars
RED=$(tput setaf 1)
GRN=$(tput setaf 2)
BLU=$(tput setaf 4)
BLD=$(tput bold)
REV=$(tput rev)
RST=$(tput sgr0) # reset colors

# functions
function replaceFileRow() {
  file=$1
  search=$2
  replace=$3

  while IFS=$'\n' read -r p || [ -n "$p" ]
  do
    if [[ $p == *$search* ]]; then
      sed -i "s/$p/$replace/g" "$file"
    fi
  done < "$file"
}

function replaceAllInFile() {
  file=$1
  search=$2
  replace=$3

  sed -i "s/$search/$replace/g" "$file"
}