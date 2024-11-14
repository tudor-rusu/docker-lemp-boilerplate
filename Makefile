# Main Makefile

# Include variables
include .docker/makefiles/*.mk

# Run "help" if called without arguments
.DEFAULT_GOAL := help

## Display this help
help:
	@MAKEFILE_LIST="${MAKEFILE_LIST}" BLUE="${BLUE}" RED="${RED}" GREEN="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}$@

########################################################################################################################
# Functions
########################################################################################################################

## replace row into a file [$FILE - file path and name; $SEARCH - search string; $REPLACE - replace string]
## ex.: make replace-file-row FILE=.docker/build/php/Dockerfile SEARCH="mysqlExtensionsInstall" REPLACE="RUN docker-php-ext-install pdo pdo_mysql mysqli"
replace-file-row:
	@${MAKEFILES_DIR}functions/$@

## replace all string occurrences into a file [$FILE - file path and name; $SEARCH - search string; $REPLACE - replace string]
## ex.: make replace-all-in-file FILE=.docker/build/php/Dockerfile SEARCH="mysqlExtensionsInstall" REPLACE="RUN docker-php-ext-install pdo pdo_mysql mysqli"
replace-all-in-file:
	@${MAKEFILES_DIR}functions/$@

## formated print a result on the screen [$LIST_STRING - array with all strings; $COLOR - color for border; $RESET - reset coloring]
## ex.:
##declare -a listString=( "mysqlExtensionsInstall" )
##listString+=( "RUN docker-php-ext-install" )
##listString+=( "pdo pdo_mysql mysqli" )
##arrString="$(printf "(" ; printf "'%s' " "${listString[@]}" ; printf ")")"
##make draw-result LIST_STRING="$arrString"
draw-result:
	@LIST_STRING="${LIST_STRING}" COLOR="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}functions/$@

## return OS type
## ex.: make check-local-os
check-local-os:
	@${MAKEFILES_DIR}functions/$@
