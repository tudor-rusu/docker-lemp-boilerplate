## [0.7.9] - 2024-11-24

- add db target to Makefile

### Modified
- CHANGELOG.md
- Makefile
- .docker/makefiles/variables.sh
- .docker/makefiles/functions/remove-script

### Added
- .docker/makefiles/build/db
- .docker/makefiles/build/dbs/mysql
- .docker/makefiles/build/dbs/postgresql
- .docker/makefiles/build/dbs/sqlite

### Deleted
- .docker/build/db/db.sh

## [0.7.8] - 2024-11-24

- add php target to Makefile

### Modified
- CHANGELOG.md
- Makefile
- .docker/makefiles/variables.sh

### Added
- .docker/makefiles/build/php

### Deleted
- .docker/build/php/php.sh

## [0.7.71] - 2024-11-17

- update nginx target to Makefile

### Modified
- CHANGELOG.md
- .docker/makefiles/build/nginx
- .docker/makefiles/variables.sh

## [0.7.7] - 2024-11-17

- add nginx target to Makefile

### Modified
- CHANGELOG.md

### Added
- .docker/makefiles/build/nginx

### Deleted
- .docker/build/nginx/nginx.sh

## [0.7.6] - 2024-11-17

- optimise functions for Makefiles

### Modified
- CHANGELOG.md
- .docker/makefiles/variables.sh
- .docker/makefiles/functions/add-script
- .docker/makefiles/functions/remove-script
- .docker/makefiles/functions/update-nginx-laravel

## [0.7.5] - 2024-11-17

- improve readability of variables for Makefiles

### Modified
- CHANGELOG.md
- Makefile
- .docker/makefiles/build/config
- .docker/makefiles/variables.mk
- .docker/makefiles/variables.sh

## [0.7.4] - 2024-11-16

- add app and build targets to Makefile

### Modified
- CHANGELOG.md
- Makefile

### Added
- .docker/makefiles/build/app

### Deleted
- .docker/build/app
- .docker/build/app/app.sh

## [0.7.3] - 2024-11-16

- add config target to Makefile

### Modified
- CHANGELOG.md
- Makefile
- .docker/makefiles/variables.mk

### Added
- .docker/makefiles/variables.sh
- .docker/makefiles/build/config

### Deleted
- .docker/config.sh
 
## [0.7.2] - 2024-11-16

- first version of all updated functions

### Modified
- CHANGELOG.md
- Makefile 
- .docker/makefiles/functions/check-local-os
- .docker/makefiles/functions/draw-result
- .docker/makefiles/functions/replace-all-in-file
- .docker/makefiles/functions/replace-file-row

### Added
- .docker/makefiles/functions/add-script
- .docker/makefiles/functions/delete-pattern-line-in-file
- .docker/makefiles/functions/fixup-cn-subject
- .docker/makefiles/functions/remove-script
- .docker/makefiles/functions/update-nginx-laravel

## [0.7.1] - 2024-11-14

- add general functions to Makefile

### Modified
- CHANGELOG.md
- Makefile

### Added
- variables.mk
- .docker/makefiles/functions/replace-file-row
- .docker/makefiles/functions/replace-all-in-file
- .docker/makefiles/functions/draw-result
- .docker/makefiles/functions/check-local-os

## [0.7.0] - 2024-11-12

- start building transition between SH files to Makefiles

### Modified
- CHANGELOG.md

### Added
- Makefile
- .docker/makefiles

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
