#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh
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
    sed -i '/dbContainerName/d' .docker/deploy/docker-compose-main.yml
    removeMysql #remove MySQL
    removePostgres #remove PostgreSQL
    removeSqlite #remove SQLite
else
    echo "${BLU}Build the ${BLD}db${RST} ${BLU}container${RST}"
    # chose the DB engine
    PS3="Please enter your choice: "
    options=("MySQL" "PostgreSQL" "SQLite" "Quit")
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
            "SQLite")
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
        COMPOSE_LIST+=(".docker/deploy/docker-compose-mysql.yml")
        replaceFileRow .docker/build/php/Dockerfile "mysqlExtensionsInstall" "RUN docker-php-ext-install pdo pdo_mysql mysqli";
        replaceFileRow .docker/build/php/Dockerfile "mysqlExtensionsEnable" "RUN docker-php-ext-enable mysqli";
        replaceFileRow ./docker.conf "MYSQL_HOST" "MYSQL_HOST='$PROJECT_NAME-mysql'";
        replaceAllInFile .docker/deploy/docker-compose-main.yml dbContainerName "$PROJECT_NAME-mysql"
        replaceAllInFile .docker/deploy/docker-compose-mysql.yml project $PROJECT_NAME
        # remove other DB engines
        removePostgres #remove PostgreSQL
        removeSqlite #remove SQLite
        while true; do
            read -rp "Actual project MySQL version is ${REV}$MYSQL_VERSION${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
            case $yn in
                [Yy]* )
                    read -rp "Enter MySQL version: " newMySQLVersion;
                    replaceFileRow ./docker.conf "MYSQL_VERSION" "MYSQL_VERSION='$newMySQLVersion'";
                    replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlVersion newMySQLVersion
                    break;;
                [Nn]* )
                    replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlVersion $MYSQL_VERSION
                    break;;
                * )
                    replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlVersion $MYSQL_VERSION
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
        replaceAllInFile .docker/deploy/docker-compose-mysql.yml "host3306" "$mysqlHostPort:3306"
        while true; do
            read -rp "Actual project MySQL database is ${REV}$MYSQL_DATABASE${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
            case $yn in
                [Yy]* )
                    read -rp "Enter database name: " newDatabase;
                    replaceFileRow ./docker.conf "MYSQL_DATABASE" "MYSQL_DATABASE='${newDatabase,,}'";
                    replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlDatabase ${newDatabase,,}
                    break;;
                [Nn]* )
                    replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlDatabase $MYSQL_DATABASE
                    break;;
                * )
                    replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlDatabase $MYSQL_DATABASE
                    break;;
            esac
        done
        replaceAllInFile .docker/deploy/docker-compose-mysql.yml mysqlRootPassword $MYSQL_ROOT_PASSWORD
        printf '\n%s\n' "${GRN}MySQL build and deploy have been made successfully.${RST}"
    fi

    # PostgresSQL
    if [ ${dbEngine} == "PostgreSQL" ]
    then
        COMPOSE_LIST+=(".docker/deploy/docker-compose-postgresql.yml")
        replaceFileRow .docker/build/php/Dockerfile "postgresExtensionsUpdate" "RUN apt-get update";
        replaceFileRow .docker/build/php/Dockerfile "postgresExtensionsPrerequisites" "RUN apt-get install -y libpq-dev";
        replaceFileRow .docker/build/php/Dockerfile "postgresExtensionsConfigure" "RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql";
        replaceFileRow .docker/build/php/Dockerfile "postgresExtensionsInstall" "RUN docker-php-ext-install pdo pdo_pgsql pgsql";
        replaceFileRow ./docker.conf "POSTGRES_HOST" "POSTGRES_HOST='$PROJECT_NAME-postgresql'";
        replaceAllInFile .docker/deploy/docker-compose-main.yml dbContainerName "$PROJECT_NAME-postgresql"
        replaceAllInFile .docker/deploy/docker-compose-postgresql.yml project $PROJECT_NAME
        # remove other DB engines
        removeMysql #remove MySQL
        removeSqlite #remove SQLite
        while true; do
            read -rp "Actual project PostgreSQL version is ${REV}$POSTGRES_VERSION${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
            case $yn in
                [Yy]* )
                    read -rp "Enter PostgreSQL version: " newPostgresVersion;
                    replaceFileRow ./docker.conf "POSTGRES_VERSION" "POSTGRES_VERSION='$newPostgresVersion'";
                    replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresVersion newPostgresVersion
                    break;;
                [Nn]* )
                    replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresVersion $POSTGRES_VERSION
                    break;;
                * )
                    replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresVersion $POSTGRES_VERSION
                    break;;
            esac
        done
        postgresHostPort=5432
        for port in $POSTGRES_PORTS
        do
          if [ $(nc -z 127.0.0.1 $port && echo "USE" || echo "FREE") == 'FREE' ]
          then
            postgresHostPort=$port
            break
          fi
        done
        replaceAllInFile .docker/deploy/docker-compose-postgresql.yml "host5432" "$postgresHostPort:5432"
        while true; do
            read -rp "Actual project PostgreSQL database is ${REV}$POSTGRES_DATABASE${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
            case $yn in
                [Yy]* )
                    read -rp "Enter database name: " newDatabase;
                    replaceFileRow ./docker.conf "POSTGRES_DATABASE" "POSTGRES_DATABASE='${newDatabase,,}'";
                    replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresDatabase ${newDatabase,,}
                    break;;
                [Nn]* )
                    replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresDatabase $POSTGRES_DATABASE
                    break;;
                * )
                    replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresDatabase $POSTGRES_DATABASE
                    break;;
            esac
        done
        replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresUser $POSTGRES_USER
        replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresPassword $POSTGRES_PASSWORD
        replaceAllInFile .docker/deploy/docker-compose-postgresql.yml postgresHoastAuthMethod $POSTGRES_HOST_AUTH_METHOD
        printf '\n%s\n' "${GRN}PostgreSQL build and deploy have been made successfully.${RST}"
    fi

    # SQLite
    if [ ${dbEngine} == "SQLite" ]
    then
        replaceFileRow .docker/build/php/Dockerfile "sqliteExtensionsUpdate" "RUN apt-get update";
        replaceFileRow .docker/build/php/Dockerfile "sqliteExtensionsPrerequisites" "RUN apt-get install -y sqlite3 libsqlite3-dev";
        replaceFileRow .docker/build/php/Dockerfile "sqliteExtensionsInstall" "RUN docker-php-ext-install pdo_sqlite";
        # remove other DB engines
        removeMysql #remove MySQL
        removePostgres #remove PostgreSQL
        sed -i '/dbContainerName/d' .docker/deploy/docker-compose-main.yml
        printf '\n%s\n' "${GRN}SQLite build and deploy have been made successfully.${RST}"
    fi

fi
