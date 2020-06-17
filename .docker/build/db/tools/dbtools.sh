#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh
source src/.env # get configuration file

dbToolsSupport=false
dbEngine="MySQL"
while true; do
    read -rp "Do you want to add DB Tools to the project? ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          dbToolsSupport=true
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

if [[ ${dbToolsSupport} = false ]]
then
    removeTools
else
    echo "${BLU}Build the ${BLD}DB Tools${RST} ${BLU}containers${RST}"
    options=()
    case ${dbEngine} in
        "MySQL")
            options+=( "Redis" "phpMyAdmin" )
            ;;
        "PostgreSQL")
            options+=( "Redis" "phpPgAdmin" )
            ;;
        "SQLite")
            options+=( "phpLiteAdmin" )
            ;;
    esac
fi

if (( ${#options[@]} ));
then
    prompt="Check an option (again to uncheck, ENTER when done): "
    while menuMultiple && read -rp "$prompt" num && [[ "$num" ]];
    do
        [[ "$num" != *[![:digit:]]* ]] &&
        (( num > 0 && num <= ${#options[@]} )) ||
        { msg="Invalid option: $num"; continue; }
        ((num--)); msg="${options[num]} was ${choices[num]:+un}checked"
        [[ "${choices[num]}" ]] && choices[num]="" || choices[num]="+"
    done

    printf "You selected";
    msg=" nothing"
    toolsList=()
    for i in ${!options[@]};
    do
        [[ "${choices[i]}" ]] && {
            printf " %s" "${options[i]}";
            msg="";
            toolsList+=( "${options[i]}" );
        }
    done
    echo "$msg"
else
    printf '%s\n' "${RED}There are no proper tools for DB engine.${RST}"
    removeTools
fi

# Redis
redisUrl=""
if [[ "${toolsList[@]}" =~ "Redis" ]];
then
    COMPOSE_LIST+=(".docker/deploy/docker-compose-redis.yml")
    replaceAllInFile .docker/deploy/docker-compose-redis.yml project $PROJECT_NAME
    redisHostPort=6379
    for port in $REDIS_PORTS
    do
      if [[ $(nc -z 127.0.0.1 ${port} && echo "USE" || echo "FREE") == 'FREE' ]]
      then
        redisHostPort=${port}
        break
      fi
    done
    replaceAllInFile .docker/deploy/docker-compose-redis.yml "hostRedis" "$redisHostPort:6379"
    replaceAllInFile .docker/deploy/docker-compose-redis.yml portRedis ${redisHostPort}
    redisCommanderHostPort=8081
    for port in $REDIS_COMMANDER_PORTS
    do
      if [[ $(nc -z 127.0.0.1 ${port} && echo "USE" || echo "FREE") == 'FREE' ]]
      then
        redisCommanderHostPort=${port}
        break
      fi
    done
    replaceAllInFile .docker/deploy/docker-compose-redis.yml "hostCommander" "$redisCommanderHostPort:8081"
    while true; do
        read -rp "Actual Redis user name is ${REV}$REDIS_USER${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
        case ${yn} in
            [Yy]* )
                read -rp "Enter Redis user name: " newUsername;
                replaceFileRow src/.env "REDIS_USER" "REDIS_USER='${newUsername,,}'";
                replaceAllInFile .docker/deploy/docker-compose-redis.yml redisUser ${newUsername,,}
                break;;
            [Nn]* )
                replaceAllInFile .docker/deploy/docker-compose-redis.yml redisUser $REDIS_USER
                break;;
            * )
                replaceAllInFile .docker/deploy/docker-compose-redis.yml redisUser $REDIS_USER
                break;;
        esac
    done
    while true; do
        read -rp "Actual Redis user password is ${REV}$REDIS_PASSWORD${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
        case ${yn} in
            [Yy]* )
                read -rp "Enter Redis user password: " newPassword;
                replaceFileRow src/.env "REDIS_PASSWORD" "REDIS_PASSWORD='${newPassword,,}'";
                replaceAllInFile .docker/deploy/docker-compose-redis.yml redisPassword ${newPassword,,}
                break;;
            [Nn]* )
                replaceAllInFile .docker/deploy/docker-compose-redis.yml redisPassword $REDIS_PASSWORD
                break;;
            * )
                replaceAllInFile .docker/deploy/docker-compose-redis.yml redisPassword $REDIS_PASSWORD
                break;;
        esac
    done
    redisUrl="Redis URL: http://$PROJECT_URL:$redisCommanderHostPort"
else
    printf '%s\n' "${RED}Redis was not selected and will not be installed.${RST}"
    removeRedis #remove Redis
fi

# phpMyAdmin
phpmyadminUrl=""
if [[ "${toolsList[@]}" =~ "phpMyAdmin" ]];
then
    COMPOSE_LIST+=(".docker/deploy/docker-compose-phpMyAdmin.yml")
    replaceAllInFile .docker/deploy/docker-compose-phpMyAdmin.yml project $PROJECT_NAME
    phpMyAdminHostPort=8082
    for port in $PMA_PORTS
    do
      if [[ $(nc -z 127.0.0.1 ${port} && echo "USE" || echo "FREE") == 'FREE' ]]
      then
        phpMyAdminHostPort=${port}
        break
      fi
    done
    replaceAllInFile .docker/deploy/docker-compose-phpMyAdmin.yml "hostphpMyAdmin" "$phpMyAdminHostPort:80"
    replaceAllInFile .docker/deploy/docker-compose-phpMyAdmin.yml mysqlHost "$MYSQL_HOST"
    replaceAllInFile .docker/deploy/docker-compose-phpMyAdmin.yml mysqlRootPassword "$MYSQL_ROOT_PASSWORD"
    replaceAllInFile .docker/deploy/docker-compose-phpMyAdmin.yml dbContainerName "$PROJECT_NAME-mysql"
    phpmyadminUrl="phpMyAdmin URL: http://$PROJECT_URL:$phpMyAdminHostPort"
else
    printf '%s\n' "${RED}phpMyAdmin was not selected and will not be installed.${RST}"
    removePhpMyAdmin #remove phpMyAdmin
fi