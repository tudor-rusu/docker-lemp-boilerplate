#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh
source src/.env # get configuration file
phpVersion=$PHP_VERSION

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
        options=("5.0" "6.x" "7.x" "8.x" "9.x" "Quit")
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
                "9.x")
                    appVanillaVersion="$opt"
                    break
                    ;;
                "10.x")
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
        majorVersion=$(echo $phpVersion | cut -c1-1)
        minorVersion=$(echo $phpVersion | cut -c3-3)
        releaseVersion=$(echo $phpVersion | cut -c5-5)
        if [[ ${#appVanillaVersion} -gt 0 ]]
        then
            echo "${GRN}You chose $appVanilla framework $appVanillaVersion version.${RST}"
            if [[ ${appVanillaVersion} == "5.0" ]]
            then
              echo "${RED}Server Requirements:${RST} PHP >= 5.4, PHP < 7"
              if [[ ${majorVersion} -ge '5' ]] && [[ ${majorVersion} -lt '7' ]]
              then
                if [[ ${majorVersion} -eq '5' ]] && [[ ${minorVersion} -ge '4' ]]
                then
                  echo "PHP $phpVersion cover requirements"
                  appLaravelSupport=true
                else
                  if [[ ${majorVersion} -gt '5' ]]
                  then
                    echo "PHP $phpVersion cover requirements"
                    appLaravelSupport=true
                  else
                    echo "PHP $phpVersion do not cover requirements"
                  fi
                fi
              else
                echo "PHP $phpVersion do not cover requirements"
              fi
            elif [[ ${appVanillaVersion} == "6.x" ]] || [[ ${appVanillaVersion} == "7.x" ]]
            then
              echo "${RED}Server Requirements:${RST} PHP >= 7.2.5"
              if [[ ${majorVersion} -ge '7' ]]
              then
                if [[ ${minorVersion} -gt '2' ]]
                then
                  echo "PHP $phpVersion cover requirements"
                  appLaravelSupport=true
                else
                  if [[ ${minorVersion} -eq '2' ]]
                  then
                    if [[ ${releaseVersion} ]] && [[ ${releaseVersion} -ge '5' ]]
                    then
                      echo "PHP $phpVersion cover requirements"
                      appLaravelSupport=true
                    else
                      echo "PHP $phpVersion do not cover requirements"
                    fi
                  else
                    echo "PHP $phpVersion do not cover requirements"
                  fi
                fi
              else
                echo "PHP $phpVersion do not cover requirements"
              fi
            elif [[ ${appVanillaVersion} == "8.x" ]]
            then
              echo "8.x"
              echo "${RED}Server Requirements:${RST} PHP >= 7.3"
              if [[ ${majorVersion} -ge '7' ]]
              then
                if [[ ${minorVersion} -ge '3' ]]
                then
                  echo "PHP $phpVersion cover requirements"
                  appLaravelSupport=true
                else
                  echo "PHP $phpVersion do not cover requirements"
                fi
              else
                echo "PHP $phpVersion do not cover requirements"
              fi
            elif [[ ${appVanillaVersion} == "9.x" ]]
            then
              echo "9.x"
              echo "${RED}Server Requirements:${RST} PHP >= 8.0"
              if [[ ${majorVersion} -ge '8' ]]
              then
                if [[ ${minorVersion} -ge '0' ]]
                then
                  echo "PHP $phpVersion cover requirements"
                  appLaravelSupport=true
                else
                  echo "PHP $phpVersion do not cover requirements"
                fi
              else
                echo "PHP $phpVersion do not cover requirements"
              fi
            elif [[ ${appVanillaVersion} == "10.x" ]]
            then
              echo "10.x"
              echo "${RED}Server Requirements:${RST} PHP >= 8.1"
              if [[ ${majorVersion} -ge '8' ]]
              then
                if [[ ${minorVersion} -ge '1' ]]
                then
                  echo "PHP $phpVersion cover requirements"
                  appLaravelSupport=true
                else
                  echo "PHP $phpVersion do not cover requirements"
                fi
              else
                echo "PHP $phpVersion do not cover requirements"
              fi
            else
               echo "invalid version $appVanillaVersion"
            fi
        fi

        if [[ ${appLaravelSupport} = false ]]
        then
          removeLaravel #remove Laravel support
          printf '%s\n' "${RED}$appVanilla $appVanillaVersion requirements have not been made successfully. Redeploy the project and set a PHP version which it is minimum required.${RST}"
        else
          if [[ ${appVanillaVersion} == "5.0" ]]
          then
            addMCryptExt #add MCrypt ext
            removeBCMathExt #remove unused ext
          else
            removeMCryptExt #remove MCrypt ext
            addBCMathExt #add BCMath ext
          fi
          updateNginxLaravel ${appVanillaVersion} #add support for Laravel in Nginx
          printf '%s\n' "${GRN}$appVanilla $appVanillaVersion requirements have been made successfully.${RST}"
        fi
    fi
fi