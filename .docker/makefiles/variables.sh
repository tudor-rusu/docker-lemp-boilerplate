#!/usr/bin/env bash
# variables repository
set -e

# get local OS
LOCAL_OS=$(make --no-print-directory check-local-os); export LOCAL_OS
HTTP_PROTOCOL='http'; export HTTP_PROTOCOL

# paths
DOCKER_DIR=.docker; export DOCKER_DIR
MAKEFILES_DIR=${DOCKER_DIR}/makefiles; export MAKEFILES_DIR
DEPLOY_DIR=${DOCKER_DIR}/deploy; export DEPLOY_DIR
BUILD_DIR=${DOCKER_DIR}/build; export BUILD_DIR
CERT_DIR=${BUILD_DIR}/cert; export CERT_DIR
BUILD_NGINX_DIR=${BUILD_DIR}/nginx; export BUILD_NGINX_DIR
BUILD_PHP_DIR=${BUILD_DIR}/php; export BUILD_PHP_DIR
BUILD_DB_DIR=${BUILD_DIR}/db; export BUILD_DB_DIR

# files
ENV_FILE=src/.env; export ENV_FILE
PHP_DOCKERFILE=${BUILD_PHP_DIR}/Dockerfile; export PHP_DOCKERFILE
PHP_LOCAL_INI_FILE=${BUILD_PHP_DIR}/local.ini; export PHP_LOCAL_INI_FILE
NGINX_APP_CONF_FILE=${BUILD_NGINX_DIR}/conf.d/app.conf; export NGINX_APP_CONF_FILE
NGINX_APP_S_CONF_FILE=${BUILD_NGINX_DIR}/conf.d/apps.conf; export NGINX_APP_S_CONF_FILE
DOCKER_COMPOSE_MAIN_FILE=${DEPLOY_DIR}/docker-compose-main.yml; export DOCKER_COMPOSE_MAIN_FILE
DOCKER_COMPOSE_MYSQL_FILE=${DEPLOY_DIR}/docker-compose-mysql.yml; export DOCKER_COMPOSE_MYSQL_FILE
DOCKER_COMPOSE_POSTGRESQL_FILE=${DEPLOY_DIR}/docker-compose-postgresql.yml; export DOCKER_COMPOSE_POSTGRESQL_FILE
DOCKER_COMPOSE_REDIS_FILE=${DEPLOY_DIR}/docker-compose-redis.yml; export DOCKER_COMPOSE_REDIS_FILE
DOCKER_COMPOSE_PHPMYADMIN_FILE=${DEPLOY_DIR}/docker-compose-phpmyadmin.yml; export DOCKER_COMPOSE_PHPMYADMIN_FILE
DOCKER_COMPOSE_PHPPGADMIN_FILE=${DEPLOY_DIR}/docker-compose-phppgadmin.yml; export DOCKER_COMPOSE_PHPPGADMIN_FILE
DOCKER_COMPOSE_PHPLITEADMIN_FILE=${DEPLOY_DIR}/docker-compose-phpliteadmin.yml; export DOCKER_COMPOSE_PHPLITEADMIN_FILE
DOCKER_COMPOSE_MAIL_SLURPER_FILE=${DEPLOY_DIR}/docker-compose-mailslurper.yml; export DOCKER_COMPOSE_MAIL_SLURPER_FILE
DOCKER_COMPOSE_MAIL_CATCHER_FILE=${DEPLOY_DIR}/docker-compose-mailcatcher.yml; export DOCKER_COMPOSE_MAIL_CATCHER_FILE
DOCKER_COMPOSE_MAIL_HOG_FILE=${DEPLOY_DIR}/docker-compose-mailhog.yml; export DOCKER_COMPOSE_MAIL_HOG_FILE

# docker variables
declare -a COMPOSE_LIST=("${DOCKER_COMPOSE_MAIN_FILE}"); export COMPOSE_LIST

# db tools array based on DB Engine
declare -a MYSQL_TOOLS=( "Redis" "phpMyAdmin" ); export MYSQL_TOOLS
declare -a POSTGRESQL_TOOLS=( "Redis" "phpPgAdmin" ); export POSTGRESQL_TOOLS
declare -a SQLITE_TOOLS=( "phpLiteAdmin" ); export SQLITE_TOOLS

# local Docker URLs
REDIS_URL=""; export REDIS_URL
PHPMYADMIN_URL=""; export PHPMYADMIN_URL
PHPPGADMIN_URL=""; export PHPPGADMIN_URL
PHPLITEADMIN_URL=""; export PHPLITEADMIN_URL
MAIL_SLURPER_URL=""; export MAIL_SLURPER_URL
MAIL_CATCHER_URL=""; export MAIL_CATCHER_URL
MAIL_HOG_URL=""; export MAIL_HOG_URL

# Colors vars
RED=$(tput setaf 1); export RED
GRN=$(tput setaf 2); export GRN
BLU=$(tput setaf 4); export BLU
BLD=$(tput bold); export BLD # bold
REV=$(tput rev); export REV # reverse
RST=$(tput sgr0); export RST # reset colors

# environment variables file
source src/.env # get configuration file
