#!/usr/bin/env bash
# Main script
set -e

declare -a COMPOSER_LIST=("docker/deploy/docker-compose-main.yml")

# include global vars and functions repository
source docker/functions.sh

####################### 1. set the config
source docker/config.sh
####################### 2. build and deploy nginx
source docker/build/nginx/nginx.sh


COMPOSER_LIST=($(echo "${COMPOSER_LIST[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))
docker-compose $(printf -- "-f %s " "${COMPOSER_LIST[@]}") config > docker/deploy/docker-compose.yml
# replace env vars in docker-compose
if [ ${startSettings} = true ]
then
  replaceAllInFile docker/deploy/docker-compose.yml "project-" "$projectName-"
fi
#docker-compose -f docker/deploy/docker-compose.yml up -d