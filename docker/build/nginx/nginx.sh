#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source docker/functions.sh
source ./docker.conf # get configuration file

# build and deploy nginx
echo "${BLU}Build the ${BLD}nginx${RST} ${BLU}container${RST}"
replaceAllInFile docker/deploy/docker-compose-main.yml "project-" "$PROJECT_NAME-"

# HTTP
nginxHttpHostPort=80
httpPortsList='80 8080 8082'
for port in $httpPortsList
do
  if [ $(nc -z 127.0.0.1 $port && echo "USE" || echo "FREE") == 'FREE' ]
  then
    nginxHttpHostPort=$port
    break
  fi
done
replaceAllInFile docker/deploy/docker-compose-main.yml "host80" "$nginxHttpHostPort"

# HTTPS
while true; do
  read -rp "Do you want to implement HTTPS access? ${RED}[y/N]${RST}: " yn
  case $yn in
      [Yy]* )
        nginxHttpsHostPort=463
        httpPortsList='443 446'
        for port in $httpPortsList
        do
          if [ $(nc -z 127.0.0.1 $port && echo "USE" || echo "FREE") == 'FREE' ]
          then
            nginxHttpsHostPort=$port
            break
          fi
        done
        replaceAllInFile docker/deploy/docker-compose-main.yml "host443" "$nginxHttpsHostPort"
        while true; do
          read -rp "Do you want to implement Let’s Encrypt certificate? ${RED}[y/N]${RST}: " yn
          case $yn in
              [Yy]* )
                eval 'docker/build/cert/letsencrypt.sh'
                break;;
              [Nn]* ) break;;
              * ) break;;
          esac
        done
        break;;
      [Nn]* )
        sed -i '/"host443"/d' docker/deploy/docker-compose-main.yml
        break;;
      * )
        sed -i '/"host443"/d' docker/deploy/docker-compose-main.yml
        break;;
  esac
done

# etc/hosts
if ! grep -Fxq "127.0.0.1 $PROJECT_URL" /etc/hosts
then
  while true; do
    read -rp "Do you want to add the project URL($PROJECT_URL) in etc/hosts? ${RED}[y/N]${RST}: " yn
    case $yn in
        [Yy]* )
          echo ${GRN}
          printf '\n%s\n%s' "# Project $PROJECT_NAME" "127.0.0.1 $PROJECT_URL" | sudo tee -a /etc/hosts
          echo ${RST}
          replaceAllInFile docker/build/nginx/conf.d/app.conf "server_name  localhost;" "server_name  $PROJECT_URL;"
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done
fi