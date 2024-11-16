#!/usr/bin/env bash
# variables repository
set -e

# get local OS
LOCAL_OS=$(make check-local-os); export LOCAL_OS

# Colors vars
RED=$(tput setaf 1); export RED
GRN=$(tput setaf 2); export GRN
BLU=$(tput setaf 4); export BLU
BLD=$(tput bold); export BLD # bold
REV=$(tput rev); export REV # reverse
RST=$(tput sgr0); export RST # reset colors

source src/.env # get configuration file
