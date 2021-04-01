#!/usr/bin/env bash
# Functions repository
set -e

# global vars
RED=$(tput setaf 1)
GRN=$(tput setaf 2)
BLU=$(tput setaf 4)
BLD=$(tput bold)
REV=$(tput rev)
RST=$(tput sgr0) # reset colors

# functions
function replaceFileRow() {
  file=$1
  search=$2
  replace=$3

  while IFS=$'\n' read -r p || [ -n "$p" ]
  do
    if [[ $p == *$search* ]]; then
      sed -i "s#$p#$replace#g" "$file"
    fi
  done < "$file"
}

function replaceAllInFile() {
  file=$1
  search=$2
  replace=$3

  sed -i "s#$search#$replace#g" "$file"
}

function longestStringInList() {
    listString=$1
    longestValue=-1
    for string in "${listString[@]}"
    do
        if [ ${#string} -gt $longestValue ]
        then
            longestValue=${#string}
        fi
    done
    echo $longestValue
}

function drawResult() {
    listString=$1
    maxString=$(longestStringInList "${listString}")
    sPre=6
    interiorWidth=$(( $maxString + sPre * 2 ))

    printf "${GRN}\u2554$(printf '\u2550%0.s' $(seq $interiorWidth))\u2557\n${RST}"
    printf "${GRN}\u2551${RST}%${interiorWidth}s${GRN}\u2551\n${RST}" "$(printf \\$(printf '%03o' 32))"

    for string in "${listString[@]}"
    do
        sApp=$(( $interiorWidth - $sPre - ${#string} ))
        printf "${GRN}\u2551${RST}%${sPre}s%s%${sApp}s${GRN}\u2551\n${RST}" "$(printf \\$(printf '%03o' 32))" "$string" "$(printf \\$(printf '%03o' 32))"
    done

    printf "${GRN}\u2551${RST}%${interiorWidth}s${GRN}\u2551\n${RST}" "$(printf \\$(printf '%03o' 32))"
    printf "${GRN}\u255A$(printf '\u2550%0.s' $(seq $interiorWidth))\u255D\n${RST}"
}

function removeMysql() {
    sed -i '/mysqlExtensionsInstall/d' .docker/build/php/Dockerfile
    sed -i '/mysqlExtensionsEnable/d' .docker/build/php/Dockerfile
    sed -i '/MySQL/d' src/.env
    sed -i '/MYSQL/d' src/.env
}

function removePostgres() {
    sed -i '/postgresExtensionsUpdate/d' .docker/build/php/Dockerfile
    sed -i '/postgresExtensionsPrerequisites/d' .docker/build/php/Dockerfile
    sed -i '/postgresExtensionsConfigure/d' .docker/build/php/Dockerfile
    sed -i '/postgresExtensionsInstall/d' .docker/build/php/Dockerfile
    sed -i '/PostgreSQL/d' src/.env
    sed -i '/POSTGRES/d' src/.env
}

function removeSqlite() {
    sed -i '/sqliteExtensionsUpdate/d' .docker/build/php/Dockerfile
    sed -i '/sqliteExtensionsPrerequisites/d' .docker/build/php/Dockerfile
    sed -i '/sqliteExtensionsInstall/d' .docker/build/php/Dockerfile
}

function removeTools() {
    removeRedis
    removePhpMyAdmin
    removePhpPgAdmin
    removePhpLiteAdmin
}

function removeRedis() {
    sed -i '/Redis/d' src/.env
    sed -i '/REDIS/d' src/.env
}

function removePhpMyAdmin() {
    sed -i '/phpMyAdmin/d' src/.env
    sed -i '/PMA/d' src/.env
}

function removePhpPgAdmin() {
    sed -i '/phpPgAdmin/d' src/.env
    sed -i '/PGA/d' src/.env
}
function removePhpLiteAdmin() {
    sed -i '/phpLiteAdmin/d' src/.env
    sed -i '/PLA/d' src/.env
}

function removeAllMailSupport() {
    removeMailSlurper
    removeMailCatcher
    removeMailHog
}

function removeMailSlurper() {
    sed -i '/mailSlurper/d' src/.env
    sed -i '/MAIL_SLURPER/d' src/.env
}

function removeMailCatcher() {
    sed -i '/mailCatcher/d' src/.env
    sed -i '/MAIL_CATCHER/d' src/.env
}

function removeMailHog() {
    sed -i '/mailHog/d' src/.env
    sed -i '/MAIL_HOG/d' src/.env
}

function removePhp74() {
    sed -i '/php74install/d' .docker/build/php/Dockerfile
}

function checkLocalOs() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        systemType="Linux"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        systemType="Mac OSX"
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        systemType="Cygwin"
    elif [[ "$OSTYPE" == "msys" ]]; then
        systemType="Windows"
    elif [[ "$OSTYPE" == "win32" ]]; then
        systemType="Windows"
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        systemType="Freebsd"
    else
        systemType="Unknown"
    fi
    echo ${systemType}
}

# If running on bash for Windows, any argument starting with a forward slash is automatically
# interpreted as a drive path. To stop that, you can prefix with 2 forward slashes instead
# of 1 - but in the specific case of openssl, that causes the first CN segment key to be read as
# "/O" instead of "O", and is skipped. We work around that by prefixing with a spurious segment,
# which will be skipped by openssl
function fixupCnSubject() {
    local result="${1}"
    case $OSTYPE in
        msys|win32) result="//XX=x${result}"
    esac
    echo "$result"
}

menuMultiple() {
    echo "Avaliable options:"
    for i in ${!options[@]}; do
        printf "%3d%s) %s\n" $((i+1)) "${choices[i]:- }" "${options[i]}"
    done
    if [[ "$msg" ]]; then echo "$msg"; fi
}