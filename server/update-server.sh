#! /bin/bash

LOGFILE="/opt/minecraft/run_server.log" 
PACKDIR="$HOME/Documents/AlmostPack/" 
MCDIR="/opt/minecraft/$1" 

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
    cp "$PACKDIR"/server/run_server.sh /opt/minecraft/ 
    sudo cp "$PACKDIR"/server/minecraft@.service /etc/systemd/system/
    log "Updated files on server"
fi
