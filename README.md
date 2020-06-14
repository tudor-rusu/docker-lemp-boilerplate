Docker LEMP Boilerplate
======================================

[![Conventional Commits][1]][2]

This project is about automate processes to deploy and set on a local machine a LEMP suite using Docker.

## Install and run on local machine

### Prerequisites
Before start install, user will need:
* (optional) [Focal Fossa][3] or latest LTS Linux distribution, and a non-root user with `sudo` privileges.
* [Composer][4]
* [Docker][5]
* [Docker Compose][6]

### Install local and run
* Clone repository
```shell script
git clone https://github.com/tudor-rusu/docker-lemp-boilerplate.git ${PROJECT_ROOT}
```
* Copy and adjust environmental settings in the root of the project, assumed `${PROJECT_ROOT}`:
```shell script
cp ${PROJECT_ROOT}/src/.env.dist ${PROJECT_ROOT}/src/.env
```
* Run the `sh` script which deploy Docker environment
```shell script
./run.sh
```

* Enjoy!

[1]: https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg
[2]: https://conventionalcommits.org/
[3]: https://releases.ubuntu.com/20.04/
[4]: https://getcomposer.org/doc/00-intro.md
[5]: https://www.docker.com/get-started
[6]: https://docs.docker.com/compose/

