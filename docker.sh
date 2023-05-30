#!/usr/bin/env bash
CMD1=${1:-}

case "$(uname -s)" in
Darwin)
    ENV_MAC=true
    ;;
*)
    ENV_MAC=false
    ;;
esac

function command_ssh() {
    bash -c "clear && docker exec -it symfony_docker_php zsh"
}

function command_start() {
    if [[ ${ENV_MAC} == false ]]; then
        docker-compose -f docker-compose.yml up -d
    else
        docker-sync start && docker-compose -f docker-compose.yml -f docker-compose-sync.yml up -d
    fi
}

function command_stop() {
    if [[ ${ENV_MAC} == false ]]; then
        docker-compose stop
    else
        docker-sync stop
        docker-compose -f docker-compose.yml -f docker-compose-sync.yml stop
    fi
}

function command_rm() {
    command_stop
    docker-compose rm -fv
}

function command_help() {
    printf "\033[33mUsage:\033[0m\n"
    printf "  $0 command\n\n"
    printf "\033[33mAvailable commands:\033[0m\n"
    awk 'BEGIN{FS="command_| ;;( ## ?)?"} /^.*?[*]+\) command_[a-zA-Z_\-]+ ;;/ {printf "  \033[32m%-30s\033[0m %s\n", $2, $3}' $0
    awk 'BEGIN{FS="^[ ]+|\\) |## "} /^.*?[^*]+\) command_[a-zA-Z_\-]+ ;;/ {printf "  \033[32m%-30s\033[0m %s\n", $2, $4}' $0
}

function command_permission() {
    docker exec -i symfony_docker_php chown www-data:www-data -R /var/www/
}

function command_setup() {
    command_start
    docker exec -w "/var/www/" symfony_docker_php cp .env.dist .env
    docker exec -w "/var/www/" symfony_docker_php composer install -oa
    docker exec -w "/var/www/" symfony_docker_php php bin/console doctrine:schema:create -n
    docker exec -i symfony_docker_php chown www-data:www-data -R /var/www/
}

function xdebug_on() {
    docker exec -i symfony_docker_php mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.disabled /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
}

function xdebug_off() {
    docker exec -i symfony_docker_php mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.disabled
}

function create_new_symfony_full_project() {
    docker exec -i symfony_docker_php symfony new --full --dir= /var/www
}

function create_new_symfony_micro_project() {
    docker exec -i symfony_docker_php symfony new --dir= /var/www
}

shift || true
case ${CMD1} in
  ssh) command_ssh ;; ## ssh into container
  start) command_start ;; ## starts docker setup
  stop) command_stop ;; ## stops docker setup
  setup) command_setup ;; ## project setup
  rm) command_rm ;; ## stops and removes docker container with their volumes
  permission) command_permission ;; ## sets the correct file permissions in the container
  xdebug:off) xdebug_off ;; ## disabled xdebug in the container
  xdebug:on) xdebug_on ;; ## enables xdebug in the container
  symfony:full) create_new_symfony_full_project ;; ## Installs the latest stable full symfony application into
  symfony:micro) create_new_symfony_micro_project ;; ## Installs the latest stable microservice symfony application
  *) command_help ;; ## Shows this help.
esac
