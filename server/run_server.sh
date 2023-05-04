#! /bin/bash

LOGFILE="/opt/minecraft/run_server.log" 
MCDIR="/opt/minecraft/$1" 

log () {
    echo -e "$1 at $(date)" >> "$LOGFILE" 
}

## option to pass nogui argument to $2 
cd "$MCDIR" && screen -dmS "server-$1" ./run.sh "$2" &

log "Ran $1" 
