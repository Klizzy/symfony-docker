if [[ "$1" == "ssh" ]]
   then
      bash -c "clear && docker exec -it klizzy_php zsh"
   fi
if [[ "$1" == "start" ]]
   then
      docker-sync start && docker-compose -f docker-compose.yml up -d
fi
if [[ "$1" == "stop" ]]
   then
      docker-sync stop && docker-compose stop
fi

#if [[ "$1" == "setup" ]]
#	then
#
#fi
