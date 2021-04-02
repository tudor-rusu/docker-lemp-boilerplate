#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh
source src/.env # get configuration file

appSupport=false
appVanilla=''
while true; do
    read -rp "Do you want to add a specific framework to the project? ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          appSupport=true
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

if [[ ${appSupport} = false ]]
then
    removeAllApp #remove all framework support
else
    echo "${BLU}Build the ${BLD}framework${RST} ${BLU}container${RST}"
    # chose the framework
    PS3="Please enter your choice: "
    options=("Laravel" "Quit")
    select opt in "${options[@]}"
    do
        case ${opt} in
            "Laravel")
                appVanilla="$opt"
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

    if [[ ${#appVanilla} -gt 0 ]]
    then
        #TODO remove other apps support
        echo "${GRN}You chose $appVanilla framework.${RST}"
    fi

    # Laravel
    if [[ ${appVanilla} == "Laravel" ]]
    then
        # chose the version
        appVanillaVersion=''
        PS3="Please enter $appVanilla framework version: "
        options=("5.0" "6.x" "7.x" "8.x" "Quit")
        select opt in "${options[@]}"
        do
            case ${opt} in
                "5.0")
                    appVanillaVersion="$opt"
                    break
                    ;;
                "6.x")
                    appVanillaVersion="$opt"
                    break
                    ;;
                "7.x")
                    appVanillaVersion="$opt"
                    break
                    ;;
                "8.x")
                    appVanillaVersion="$opt"
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

        appLaravelSupport=false
        if [[ ${#appVanillaVersion} -gt 0 ]]
        then
            echo "${GRN}You chose $appVanilla framework $appVanillaVersion version.${RST}"
            if [[ ${appVanillaVersion} == "5.0" ]]
            then
              echo "5.0"
              appLaravelSupport=true
            elif [[ ${appVanillaVersion} == "6.x" ]]
            then
              echo "6.x"
              appLaravelSupport=true
            elif [[ ${appVanillaVersion} == "7.x" ]]
            then
              echo "7.x"
              appLaravelSupport=true
            elif [[ ${appVanillaVersion} == "6.x" ]]
            then
              echo "8.x"
              appLaravelSupport=true
            else
               echo "invalid version $appVanillaVersion"
            fi
        fi

        if [[ ${appLaravelSupport} = false ]]
        then
            removeLaravel #remove Laravel support
        else
            printf '\n%s\n' "${GRN}$appVanilla $appVanillaVersion requirements have been made successfully.${RST}"
        fi
    fi
fi