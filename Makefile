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

## replaceFileRow [$FILE - file path and name; $SEARCH - search string; $REPLACE - replace string]
replace-file-row:
	@${MAKEFILES_DIR}functions/$@

## replaceAllInFile [$FILE - file path and name; $SEARCH - search string; $REPLACE - replace string]
replace-all-in-file:
	@${MAKEFILES_DIR}functions/$@
