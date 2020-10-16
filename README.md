# Docker Symfony setup

Docker setup for symfony or other php projects. It currently supports MacOS (docker-sync) and Unix (native docker volumes).

**Current Specs**
* xdebug
* ZSH
* PHP:7.4
* NPM:latest, NVM:0.33.11, NODE:12.18.2 LTS, YARN:latest
* Docker-sync / native docker volumes


## Setup

Checkout your project into the `/www` directory and set the `APACHE_DOCUMENT_ROOT` env in the docker-compose file, to match your framework / setup.
Type `./docker.sh` to see a help message for additional commands.

### Start Setup
```bash
./docker.sh start
```

### Stop Setup
```bash
./docker.sh stop
```

### Connect into container
```bash
./docker.sh ssh
```
