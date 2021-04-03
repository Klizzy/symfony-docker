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
  bash -c "clear && docker exec -it klizzy_php zsh"
}
function command_start() {
  if [[ ${ENV_MAC} == false  ]]
   then
       docker-compose -f docker-compose.yml up -d
   fi
       docker-sync start && docker-compose -f docker-compose-sync.yml -f docker-compose.yml up -d

}

function command_stop() {
  if [[ ${ENV_MAC} == false  ]]
   then
       docker-compose stop
   fi
    docker-sync stop && docker-compose stop
}

function command_help() {
  printf "\033[33mUsage:\033[0m\n"
  printf "  $0 command\n\n"
  printf "\033[33mAvailable commands:\033[0m\n"
  awk 'BEGIN{FS="command_| ;;( ## ?)?"} /^.*?[*]+\) command_[a-zA-Z_\-]+ ;;/ {printf "  \033[32m%-30s\033[0m %s\n", $2, $3}' $0
  awk 'BEGIN{FS="^[ ]+|\\) |## "} /^.*?[^*]+\) command_[a-zA-Z_\-]+ ;;/ {printf "  \033[32m%-30s\033[0m %s\n", $2, $4}' $0
}

function command_setup(){
  command_start
  docker exec -w "/var/www/" klizzy_php composer self-update --2
  docker exec -w "/var/www/" klizzy_php cp .env.dist .env
  docker exec -w "/var/www/" klizzy_php composer install -oa
  docker exec -w "/var/www/" klizzy_php php bin/console doctrine:schema:create -n
  docker exec -i klizzy_php chown www-data:www-data -R /var/www/
}

shift || true
case ${CMD1} in
  ssh) command_ssh ;; ## ssh into container
  start) command_start ;; ## starts docker setup
  stop) command_stop ;; ## stops docker setup
  setup) command_setup ;; ## project setup
  *) command_help ;; ## Shows this help.
esac
