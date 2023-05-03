#! /bin/bash

PACKDIR="$HOME/Documents/AlmostPack/" 
MCDIR="/opt/minecraft/RustBox/" 
LOGFILE="/opt/minecraft/run_server.log" 

log () {
    echo -e "$1 at $(date)" >> "$LOGFILE" 
}

if [ -e "$PACKDIR" ] && [ -e "$MCDIR" ]; then
    cd "$PACKDIR" && git pull 
    log "Pulled git repo" 
    DIFF_OUTPUT=$(diff -r "$PACKDIR/server/mods" "$MCDIR/mods") 
else 
    log "Directory not found" 
fi

if [[ -n $DIFF_OUTPUT ]]; then
    ## this may leave deprecated mods. we shall see. 
    cp -rf "$PACKDIR"/server/mods/ "$MCDIR"/ 
    log "Updated mods on server"
fi

## option to pass nogui argument to $1
cd "$MCDIR" && bash ./run.sh "$1" &

log "Ran RustBox" 
