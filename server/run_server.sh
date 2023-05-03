#! /bin/bash

MCDIR="$HOME/Documents/RustBox/" 
PACKDIR="$HOME/Documents/AlmostPack/" 
LOGFILE="$HOME/run_server.log" 

log () {
    echo -e "$1 at $(date)" >> $LOGFILE 
}

if [ -e "$PACKDIR" ]
then
    cd $PACKDIR     &&      git pull
    log "Pulled git repo"
    if [ -e "$MCDIR" ]
    then
            cp -rf $PACKDIR/server/mods/ $MCDIR/mods/
    else
        log "Server dir not found" 
    fi 
else 
    log "Pack dir not found" 
fi


# option to pass nogui argument to $1
cd $MCDIR       &&      bash ./run.sh $1 &

log "Ran RustBox" 

