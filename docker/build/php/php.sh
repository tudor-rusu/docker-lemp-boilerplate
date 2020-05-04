#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source docker/functions.sh
source ./docker.conf # get configuration file
phpVersion=$PHP_VERSION

# build and deploy php
echo "${BLU}Build the ${BLD}php${RST} ${BLU}container${RST}"
replaceAllInFile docker/deploy/docker-compose-main.yml project $PROJECT_NAME
replaceAllInFile docker/build/php/Dockerfile php-version $phpVersion
replaceAllInFile docker/build/nginx/conf.d/app.conf php_container_name "$PROJECT_NAME-app"
replaceAllInFile docker/build/nginx/conf.d/apps.conf php_container_name "$PROJECT_NAME-app"

while true; do
    read -rp "Actual project PHP version is ${REV}$phpVersion${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
    case $yn in
        [Yy]* )
          read -rp "Enter PHP version: " newPhpVersion;
          replaceFileRow ./docker.conf "PHP_VERSION" "PHP_VERSION='$newPhpVersion'";
          replaceAllInFile docker/build/php/Dockerfile php-version $newPhpVersion
          phpVersion=$newPhpVersion
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

printf '\n%s\n' "${GRN}PHP build and deploy have been made successfully.${RST}"