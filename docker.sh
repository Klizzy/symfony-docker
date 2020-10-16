case "$(uname -s)" in
  Darwin)
    ENV_MAC=true
    ;;
  *)
    ENV_MAC=false
   ;;
esac

if [[ "$1" == "ssh" ]]
   then
      bash -c "clear && docker exec -it klizzy_php zsh"
   fi
if [[ "$1" == "start" ]]
   then
       if [[ ${ENV_MAC} == false ]]; then
       docker-compose -f docker-compose.yml up -d
   fi
        docker-sync start && docker-compose -f docker-compose-sync.yml -f docker-compose.yml up -d
fi
if [[ "$1" == "stop" ]]
   then
      docker-sync stop && docker-compose stop
fi

#if [[ "$1" == "setup" ]]
#	then
#
#fi
