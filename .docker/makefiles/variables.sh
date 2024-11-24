#!/usr/bin/env bash
# variables repository
set -e

# get local OS
LOCAL_OS=$(make --no-print-directory check-local-os); export LOCAL_OS
HTTP_PROTOCOL='http'; export HTTP_PROTOCOL

# paths
DOCKER_DIR=.docker; export DOCKER_DIR
MAKEFILES_DIR=${DOCKER_DIR}/makefiles; export MAKEFILES_DIR
BUILD_DIR=${DOCKER_DIR}/build; export BUILD_DIR
BUILD_DB_DIR=${BUILD_DIR}/db; export BUILD_DB_DIR
BUILD_NGINX_DIR=${BUILD_DIR}/nginx; export BUILD_NGINX_DIR
BUILD_PHP_DIR=${BUILD_DIR}/php; export BUILD_PHP_DIR
DEPLOY_DIR=${DOCKER_DIR}/deploy; export DEPLOY_DIR
CERT_DIR=${DEPLOY_DIR}/cert; export CERT_DIR

# files
ENV_FILE=src/.env; export ENV_FILE
PHP_DOCKERFILE=${BUILD_PHP_DIR}/Dockerfile; export PHP_DOCKERFILE
PHP_LOCAL_INI_FILE=${BUILD_PHP_DIR}/local.ini; export PHP_LOCAL_INI_FILE
NGINX_APP_CONF_FILE=${BUILD_NGINX_DIR}/conf.d/app.conf; export NGINX_APP_CONF_FILE
NGINX_APP_S_CONF_FILE=${BUILD_NGINX_DIR}/conf.d/apps.conf; export NGINX_APP_S_CONF_FILE
DOCKER_COMPOSE_MAIN_FILE=${DEPLOY_DIR}/docker-compose-main.yml; export DOCKER_COMPOSE_MAIN_FILE

# docker variables
declare -a COMPOSE_LIST=("${DOCKER_COMPOSE_MAIN_FILE}"); export COMPOSE_LIST

# Colors vars
RED=$(tput setaf 1); export RED
GRN=$(tput setaf 2); export GRN
BLU=$(tput setaf 4); export BLU
BLD=$(tput bold); export BLD # bold
REV=$(tput rev); export REV # reverse
RST=$(tput sgr0); export RST # reset colors

# environment variables file
source src/.env # get configuration file
