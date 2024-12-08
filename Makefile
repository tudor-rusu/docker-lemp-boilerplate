# Main Makefile

# Include variables
include .docker/makefiles/*.mk

# Run "help" if called without arguments
.DEFAULT_GOAL := help

## Display this help
help:
	@MAKEFILE_LIST="${MAKEFILE_LIST}" BLUE="${BLUE}" RED="${RED}" GREEN="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}$@

########################################################################################################################
# Installation
########################################################################################################################

## installation configurations
config:
	@${MAKEFILES_DIR}build/$@

## build specific apps containers and settings
app:
	@${MAKEFILES_DIR}build/$@

## build nginx containers and settings
nginx:
	@${MAKEFILES_DIR}build/$@

## build php containers and settings
php:
	@${MAKEFILES_DIR}build/$@

## build db containers and settings
db:
	@${MAKEFILES_DIR}build/$@

mysql:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/dbs/$@

postgresql:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/dbs/$@

sqlite:
	@${MAKEFILES_DIR}build/dbs/$@

db-tools:
	@DB_ENGINE="${DB_ENGINE}" ${MAKEFILES_DIR}build/$@

redis:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/dbs/$@

phpmyadmin:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/dbs/$@

phppgadmin:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/dbs/$@

phpliteadmin:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/dbs/$@

## build mail containers and settings
mail:
	@${MAKEFILES_DIR}build/$@

mail-slurper:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/mails/$@

mail-catcher:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/mails/$@

mail-hog:
	@COMPOSE_LIST_UPDATED="${COMPOSE_LIST_UPDATED}" ${MAKEFILES_DIR}build/mails/$@

## build all steps
build: config app nginx php db mail

########################################################################################################################
# Functions
########################################################################################################################

## replace row into a file [$FILE - file path and name; $SEARCH - search string; $REPLACE - replace string]
replace-file-row:
	@${MAKEFILES_DIR}functions/$@

## replace all string occurrences into a file [$FILE - file path and name; $SEARCH - search string; $REPLACE - replace string]
replace-all-in-file:
	@${MAKEFILES_DIR}functions/$@

## delete pattern matching line in specific file [$PATTERN - string which must delete; $FILE - file path and name]
delete-pattern-line-in-file:
	@PATTERN="${PATTERN}" FILE="${FILE}" RED="${RED}" GREEN="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}functions/$@

## formated print a result on the screen [$LIST_STRING - array with all strings; $COLOR - color for border; $RESET - reset coloring]
draw-result:
	@LIST_STRING="${LIST_STRING}" COLOR="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}functions/$@

## return OS type
check-local-os:
	@${MAKEFILES_DIR}functions/$@

## return CN Subject fixed for Windows [$CN_SUBJECT - CN Subject in nginx config]
fixup-cn-subject:
	@CN_SUBJECT="${CN_SUBJECT}" ${MAKEFILES_DIR}functions/$@

## add scripts [$SCRIPT_TYPE - string with what script will be added]
add-script:
	@SCRIPT_TYPE="${SCRIPT_TYPE}" RED="${RED}" GREEN="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}functions/$@

## remove scripts [$SCRIPT_TYPE - string with what script will be added]
remove-script:
	@SCRIPT_TYPE="${SCRIPT_TYPE}" RED="${RED}" GREEN="${GREEN}" RESET="${RESET}" ${MAKEFILES_DIR}functions/$@

## update app script by adding support for Laravel in Nginx, based on version [$VERSION - Laravel version]
update-nginx-laravel:
	@VERSION="${VERSION}" RED="${RED}" RESET="${RESET}" ${MAKEFILES_DIR}functions/$@
