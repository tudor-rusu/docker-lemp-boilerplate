#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh
source src/.env # get configuration file

mailSupport=false
while true; do
    read -rp "Do you want to add Mail Support to the project? ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          mailSupport=true
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

if [[ ${mailSupport} = false ]]
then
    removeAllMailSupport #remove all mail support settings
else
    echo "${BLU}Build the ${BLD}Mail Support${RST} ${BLU}container${RST}"
    # chose the Mail engine
    PS3="Please enter your choice: "
    options=("MailSlurper" "Mailtrap" "MailCatcher" "MailHog" "Quit")
    select opt in "${options[@]}"
    do
        case ${opt} in
            "MailSlurper")
                mailEngine="$opt"
                break
                ;;
            "Mailtrap")
                mailEngine="$opt"
                break
                ;;
            "MailCatcher")
                mailEngine="$opt"
                break
                ;;
            "MailHog")
                mailEngine="$opt"
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

    if [[ ${#mailEngine} -gt 0 ]]
    then
        echo "${GRN}You chose $mailEngine Engine.${RST}"
    fi

    # MailSlurper
    if [[ ${mailEngine} == "MailSlurper" ]]
    then
        COMPOSE_LIST+=(".docker/deploy/docker-compose-mailslurper.yml")
        replaceFileRow src/.env "MYSQL_HOST" "MYSQL_HOST='$PROJECT_NAME-mysql'";
        replaceAllInFile .docker/deploy/docker-compose-mailslurper.yml project $PROJECT_NAME
        # remove other mail engines
#        removeMailtrap #remove Mailtrap
#        removeMailCatcher #remove MailCatcher
#        removeMailHog #remove MailHog
        mailSlurperSmtpHostPort=2500
        for port in $MAIL_SLURPER_SMTP_PORT
        do
          if [[ $(nc -z 127.0.0.1 ${port} && echo "USE" || echo "FREE") == 'FREE' ]]
          then
            mailSlurperSmtpHostPort=${port}
            break
          fi
        done
        replaceAllInFile .docker/deploy/docker-compose-mailslurper.yml "hostslurpersmtp" "$mailSlurperSmtpHostPort:2500"
        mailSlurperWwwHostPort=8080
        for port in $MAIL_SLURPER_WWW_PORT
        do
          if [[ $(nc -z 127.0.0.1 ${port} && echo "USE" || echo "FREE") == 'FREE' ]]
          then
            mailSlurperWwwHostPort=${port}
            break
          fi
        done
        replaceAllInFile .docker/deploy/docker-compose-mailslurper.yml "hostslurperwww" "$mailSlurperWwwHostPort:8080"
        mailSlurperUrl="MailSlurper URL: http://$PROJECT_URL:$mailSlurperWwwHostPort"
        mailSlurperServiceHostPort=8085
        for port in $MAIL_SLURPER_SERVICE_PORT
        do
          if [[ $(nc -z 127.0.0.1 ${port} && echo "USE" || echo "FREE") == 'FREE' ]]
          then
            mailSlurperServiceHostPort=${port}
            break
          fi
        done
        replaceAllInFile .docker/deploy/docker-compose-mailslurper.yml "hostslurperservice" "$mailSlurperServiceHostPort:8085"
        printf '\n%s\n' "${GRN}MailSlurper build and deploy have been made successfully.${RST}"
    fi
fi