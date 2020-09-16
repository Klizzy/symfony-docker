# Docker Symfony4 Kickstart Setup

Just my personal docker symfony 4 boilerplate to kickstart development - nothing special here 😉

**Current Specs**
* xdebug
* ZSH
* PHP:7.4
* NPM:latest, NVM:0.33.11, NODE:12.18.2 LTS, YARN:latest
* Docker-sync


## Setup

Checkout your project into the `/www` directory and set the `APACHE_DOCUMENT_ROOT` env in the docker-compose file, to match your framework / setup.

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
