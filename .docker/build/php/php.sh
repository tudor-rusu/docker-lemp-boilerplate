#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh
source src/.env # get configuration file
phpVersion=$PHP_VERSION

# build and deploy php
echo "${BLU}Build the ${BLD}php${RST} ${BLU}container${RST}"
replaceAllInFile .docker/deploy/docker-compose-main.yml project $PROJECT_NAME
replaceAllInFile .docker/build/php/Dockerfile app-gid $APP_GID
replaceAllInFile .docker/build/php/Dockerfile app-uid $APP_UID
replaceAllInFile .docker/build/php/local.ini UPLOAD_MAX_FILESIZE $UPLOAD_MAX_FILESIZE
replaceAllInFile .docker/build/php/local.ini POST_MAX_SIZE $POST_MAX_SIZE
replaceAllInFile .docker/build/php/local.ini PHP_MEMORY_LIMIT $PHP_MEMORY_LIMIT
replaceAllInFile .docker/build/php/local.ini PHP_TIMEZONE $PHP_TIMEZONE
replaceAllInFile .docker/build/nginx/conf.d/app.conf php_container_name "$PROJECT_NAME-app"
replaceAllInFile .docker/build/nginx/conf.d/apps.conf php_container_name "$PROJECT_NAME-app"

while true; do
    read -rp "Actual project PHP version is ${REV}$phpVersion${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          read -rp "Enter PHP version: " newPhpVersion;
          replaceFileRow src/.env "PHP_VERSION" "PHP_VERSION='$newPhpVersion'";
          replaceAllInFile .docker/build/php/Dockerfile php-version $newPhpVersion
          phpVersion=$newPhpVersion
          break;;
        [Nn]* )
          replaceAllInFile .docker/build/php/Dockerfile php-version $phpVersion
          break;;
        * )
          replaceAllInFile .docker/build/php/Dockerfile php-version $phpVersion
          break;;
    esac
done

# add modifications for PHP >=7.4
# get minor version
minorVersion=$(echo $phpVersion | cut -c3-3)
if [[ ${minorVersion} -ge '4' ]]
then
  replaceAllInFile .docker/build/php/Dockerfile "php74install" "libonig-dev libzip-dev";
  replaceAllInFile .docker/build/php/Dockerfile "gdConfiguration" "RUN docker-php-ext-configure gd --enable-gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/";
else
  removePhp74 #remove PHP >=7.4 scripts
  replaceAllInFile .docker/build/php/Dockerfile "gdConfiguration" "RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/";
fi

printf '\n%s\n' "${GRN}PHP build and deploy have been made successfully.${RST}"