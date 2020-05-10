#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source docker/functions.sh
source ./docker.conf # get configuration file

dbSupport=false
dbEngine=''
while true; do
    read -rp "Do you want to add DB support to the project? ${RED}[y/N]${RST}: " yn
    case $yn in
        [Yy]* )
          dbSupport=true
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

if [ ${dbSupport} = false ]
then
    sed -i '/mysqlExtensionsInstall/d' docker/build/php/Dockerfile
    sed -i '/mysqlExtensionsEnable/d' docker/build/php/Dockerfile
    sed -i '/dbContainerName/d' docker/deploy/docker-compose-main.yml
else
    echo "${BLU}Build the ${BLD}db${RST} ${BLU}container${RST}"
    # chose the DB engine
    PS3="Please enter your choice: "
    options=("MySQL" "PostgreSQL" "SQLite3" "Quit")
    select opt in "${options[@]}"
    do
        case $opt in
            "MySQL")
                dbEngine="$opt"
                break
                ;;
            "PostgreSQL")
                dbEngine="$opt"
                break
                ;;
            "SQLite3")
                dbEngine="$opt"
                break
                ;;
            "Quit")
                break
                ;;
            * )
                echo "invalid option $REPLY"
                break
                ;;
        esac
    done

    if [ ${#dbEngine} -gt 0 ]
    then
        echo "${GRN}You chose $dbEngine Engine.${RST}"
    fi

    # MySQL
    if [ ${dbEngine} == "MySQL" ]
    then
        COMPOSE_LIST+=("docker/deploy/docker-compose-mysql.yml")
        replaceFileRow docker/build/php/Dockerfile "mysqlExtensionsInstall" "RUN docker-php-ext-install pdo_mysql mysqli";
        replaceFileRow docker/build/php/Dockerfile "mysqlExtensionsEnable" "RUN docker-php-ext-enable mysqli";
        replaceFileRow ./docker.conf "MYSQL_HOST" "MYSQL_HOST='$PROJECT_NAME-mysql'";
        replaceAllInFile docker/deploy/docker-compose-main.yml dbContainerName "$PROJECT_NAME-mysql"
        replaceAllInFile docker/deploy/docker-compose-mysql.yml project $PROJECT_NAME
        while true; do
            read -rp "Actual project MySQL version is ${REV}$MYSQL_VERSION${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
            case $yn in
                [Yy]* )
                    read -rp "Enter MySQL version: " newMySQLVersion;
                    replaceFileRow ./docker.conf "MYSQL_VERSION" "MYSQL_VERSION='$newMySQLVersion'";
                    replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlVersion newMySQLVersion
                    break;;
                [Nn]* )
                    replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlVersion $MYSQL_VERSION
                    break;;
                * )
                    replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlVersion $MYSQL_VERSION
                    break;;
            esac
        done
        mysqlHostPort=3306
        for port in $MYSQL_PORTS
        do
          if [ $(nc -z 127.0.0.1 $port && echo "USE" || echo "FREE") == 'FREE' ]
          then
            mysqlHostPort=$port
            break
          fi
        done
        replaceAllInFile docker/deploy/docker-compose-mysql.yml "host3306" "$mysqlHostPort:3306"
        while true; do
            read -rp "Actual project MySQL database is ${REV}$MYSQL_DATABASE${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
            case $yn in
                [Yy]* )
                    read -rp "Enter database name: " newDatabase;
                    replaceFileRow ./docker.conf "MYSQL_DATABASE" "MYSQL_DATABASE='${newDatabase,,}'";
                    replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlDatabase ${newDatabase,,}
                    break;;
                [Nn]* )
                    replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlDatabase $MYSQL_DATABASE
                    break;;
                * )
                    replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlDatabase $MYSQL_DATABASE
                    break;;
            esac
        done
        replaceAllInFile docker/deploy/docker-compose-mysql.yml mysqlRootPassword $MYSQL_ROOT_PASSWORD
        printf '\n%s\n' "${GRN}MySQL build and deploy have been made successfully.${RST}"
    fi

fi
