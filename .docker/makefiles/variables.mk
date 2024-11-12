# Variables for Makefiles

# Define colors as variables
tput	:= $(shell command -v tput)
RED		:= "$$($(tput) setaf 1)"
GREEN	:= "$$($(tput) setaf 2)"
BLUE	:= "$$($(tput) setaf 4)"
RESET	:= "$$($(tput) sgr0)"

# Configurations
COMPOSE_LIST = .docker/deploy/docker-compose-main.yml
DOCKER_DIR = .docker
MAKEFILES_DIR = $(DOCKER_DIR)/makefiles/
