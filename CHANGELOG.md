## [0.6.1] - 2023-03-06

- build(app): add Laravel 9.x in app.sh

### Modified
- CHANGELOG.md
- app.sh

## [0.6.0] - 2022-04-03

- refactor(php): refactor php.sh related to better check of php version
- build(app): add Laravel 9.x in app.sh
- refactor(docker): refactor docker files for update to PHP 8 and MySQL 8
- buil(php): build xdebug support

### Modified
- CHANGELOG.md
- run script
- functions.sh
- php/Dockerfile
- app.sh
- php.sh
- docker-compose-mysql.yml
- src/index.php

### Removed
- mysql/my.cnf file

## [0.5.0] - 2021-04-02
0
### Added
- app.sh script

### Modified
- CHANGELOG.md
- run script
- app.conf and apps.conf
- php/Dockerfile
- functions.sh

## [0.4.1] - 2021-04-01

### Modified
- CHANGELOG.md
- run script

## [0.4.0] - 2021-04-01

### Modified
- CHANGELOG.md
- functions script
- php script
- php Dockerfile

## [0.3.0] - 2020-06-21

### Added
- mail.sh script
- docker-compose-mailcatcher.yml
- docker-compose-mailhog.yml  
- docker-compose-mailslurper.yml

### Modified
- CHANGELOG.md
- run.sh script
- index.php
- functions script
- dbtools script
- .env.dist

## [0.2.0] - 2020-06-20

### Added
- dbtools.sh script
- docker-compose-phpliteadmin.yml
- docker-compose-phpmyadmin.yml  
- docker-compose-phppgadmin.yml
- docker-compose-redis.yml

### Modified
- CHANGELOG.md
- run.sh script
- index.php
- functions script
- db script
- .env.dist

## [0.1.5] - 2020-06-14

### Added
- .env files

### Removed
- docker.conf file

### Modified
- CHANGELOG.md and REDME.md
- run.sh script
- index.php
- functions and config scripts
- nginx, php and db scripts
- .gitignore

## [0.1.4] - 2020-05-14

### Modified
- CHANGELOG.md
- functions script
- php Dockerfile
- db.sh script for implement SQLite

## [0.1.3] - 2020-05-13

### Added
- postgresql command extension file
- docker-compose-postgresql.yml

### Modified
- CHANGELOG.md
- functions script
- docker-compose-main 
- php Dockerfile
- db.sh script for build and deploy DB container

## [0.1.2] - 2020-05-10

### Added
- db.sh script for build and deploy DB container
- mysql conf file
- docker-compose-mysql

### Modified
- CHANGELOG.md
- nginx, run and functions scripts
- docker-compose-main 
- php Dockerfile

## [0.1.1] - 2020-05-04

### Added
- php Dockerfile
- php script

### Modified
- CHANGELOG.md
- run script
- docker-compose

## [0.1.0] - 2020-04-26

### Added
- SSL self-signed certification
- nginx Dockerfile
- separate config for nginx
- docker conf

### Modified
- CHANGELOG.md
- nginx script
- docker-compose

## [0.0.2] - 2020-04-20

### Added
- script files for project configuration
- script files for nginx container build
- script file with global vars and functions
- folders structure

### Modified
- CHANGELOG.md

## [0.0.1] - 2020-04-16

### Added
- README.md, LICENSE and CHANGELOG.md
- initial commit