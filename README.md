# Docker Symfony setup

Docker setup for symfony or other php projects. It currently supports MacOS (Mutagen + mutagen-compose) and Unix (native docker volumes).
This repository currently contains support for PHP 7.2 up to PHP 8.2.1. Just checkout the needed tag and you're good to go.

**Current Specs**
* PHP: 8.2.12
* PHP modules: Xdebug 3, redis, amqp, soap, pcov, opcache, apcu
* Composer 2.4.4
* MySQL: 8.0.33
* NPM: 8.19.3, NVM: 0.39.1, NODE: 16.19.0 LTS, YARN: 1.22.19, BUN: 1.0.13
* [Symfony-cli](https://symfony.com/download)
* [Deployer](https://github.com/deployphp/deployer)
* ZSH
* [Mutagen](https://mutagen.io/documentation/introduction/installation) + [mutagen-compose](https://accesto.com/blog/docker-on-mac-how-to-speed-it-up/#mutagen) (**Required on MacOS**) / native docker volumes (OS will be detected)
* Docker container for: mysql, redis, rabbitmq and mailcatcher


## Setup

Checkout your project into the `/www` directory and set the `APACHE_DOCUMENT_ROOT` env in the docker-compose file, to match your framework / setup.
Type `./docker.sh` to see a help message for additional commands.

### Start setup
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

### Build project
```bash
./docker.sh setup
```

### Stop and remove docker container with their volumes
```bash
./docker.sh rm
```

### Symfony full install
It runs `symfony new --webapp ./` inside the docker container working dir. After that you'll have a running symfony default application. Change the DB credentials in the `www/.env`and you are good to go
```bash
./docker.sh symfony:full
```

### Symfony microservice install
It runs `symfony new ./` inside the docker container working dir. After that you'll have a running symfony microservice application. Change the DB credentials in the `www/.env`and you are good to go
```bash
./docker.sh symfony:micro
```

### Enables xdebug
```bash
./docker.sh xdebug:on
```

### Disables xdebug
```bash
./docker.sh xdebug:off
```

## Aliases
if you connect into the container, it will have the following aliases:

### Enable xdebug
```bash
xdebug-enable
```

### Disable xdebug
```bash
xdebug-disable
```
