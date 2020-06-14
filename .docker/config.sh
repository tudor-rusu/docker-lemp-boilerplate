#!/usr/bin/env bash
# Configuration script
set -e

# include global vars and functions repository
source .docker/functions.sh

localOs=$(checkLocalOs)
echo ${localOs}
# set the project configuration
echo "${BLU}Set the project configuration${RST}"
startSettings=false
while true; do
    read -rp "Do you wish to set the configuration? ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* ) startSettings=true; break;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

source src/.env # get configuration file
projectName=$PROJECT_NAME
projectUrl=$PROJECT_URL
projectDescription=$PROJECT_DESCRIPTION
projectAuthor=$PROJECT_AUTHOR
projectGithub=$PROJECT_GITHUB

if [[ ${startSettings} = true ]]
then
  while true; do
    read -rp "Actual project name is ${REV}$PROJECT_NAME${RST}, do you want to change it? ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          read -rp "Enter project name (use '-' instead 'space' between words): " newProjectName;
          replaceFileRow src/.env "PROJECT_NAME" "PROJECT_NAME='$newProjectName'";
          projectName=${newProjectName}
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done
  while true; do
    read -rp "Actual project URL is ${REV}$PROJECT_URL${RST}, do you want to change it ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          read -rp "Enter project URL (use '-' instead 'space' between words): " newProjectURL;
          replaceFileRow src/.env "PROJECT_URL" "PROJECT_URL='$newProjectURL'";
          projectUrl=${newProjectURL}
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done
  while true; do
    read -rp "Actual project description is ${REV}$PROJECT_DESCRIPTION${RST}, do you want to change it ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          read -rp "Enter project description: " newProjectDescription;
          replaceFileRow src/.env "PROJECT_DESCRIPTION" "PROJECT_DESCRIPTION='$newProjectDescription'";
          projectDescription=${newProjectDescription}
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done
  while true; do
    read -rp "Actual project author is ${REV}$PROJECT_AUTHOR${RST}, do you want to change it ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          read -rp "Enter project author: " newProjectAuthor;
          replaceFileRow src/.env "PROJECT_AUTHOR" "PROJECT_AUTHOR='$newProjectAuthor'";
          projectAuthor=${newProjectAuthor}
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done
  while true; do
    read -rp "Actual project Github URL is ${REV}$PROJECT_GITHUB${RST}, do you want to change it ${RED}[y/N]${RST}: " yn
    case ${yn} in
        [Yy]* )
          read -rp "Enter project Github URL: " newProjectGithub;
          replaceFileRow src/.env "PROJECT_GITHUB" "PROJECT_GITHUB='$newProjectGithub'";
          projectGithub=${newProjectGithub}
          break;;
        [Nn]* ) break;;
        * ) break;;
    esac
  done
  printf '\n%s\n' "${GRN}All changes to the configuration file have been made successfully.${RST}"
fi


