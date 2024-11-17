#!/usr/bin/env bash
# variables repository
set -e

# get local OS
LOCAL_OS=$(make --no-print-directory check-local-os); export LOCAL_OS

# paths
DOCKER_DIR=.docker; export DOCKER_DIR
ENV_FILE=src/.env; export ENV_FILE
COMPOSE_LIST=${DOCKER_DIR}/deploy/docker-compose-main.yml; export COMPOSE_LIST
MAKEFILES_DIR=${DOCKER_DIR}/makefiles; export MAKEFILES_DIR

# Colors vars
RED=$(tput setaf 1); export RED
GRN=$(tput setaf 2); export GRN
BLU=$(tput setaf 4); export BLU
BLD=$(tput bold); export BLD # bold
REV=$(tput rev); export REV # reverse
RST=$(tput sgr0); export RST # reset colors

# environment variables file
source src/.env # get configuration file
