#! /bin/bash
## check for sudo || run this script as sudo 
[ "$UID" -eq 0 ] || exec sudo bash "$0" "$@"
## cd into the script's source directory 
cd "${0%/*}" && pwd  

LOGFILE="/opt/minecraft/server.log" 
PACKDIR="${0%/*}" ## AlmostPack/server/ 
MCDIR="/opt/minecraft/$1" 

log () {
    echo "$1" 
    echo -e "[$(date)] $1" >> "$LOGFILE" 
}   

if [ -e "$PACKDIR" ] && [ -e "$MCDIR" ]; then
    cd "$PACKDIR" && git pull 
    log "Pulled git repo" 
    DIFF_OUTPUT=$(diff -r "$PACKDIR/mods" "$MCDIR/mods") 
else 
    log "Directory not found" 
fi

if [[ -n $DIFF_OUTPUT ]]; then
    ## this may leave deprecated mods. 
    cp -rf "$PACKDIR/mods/" "$MCDIR/" 
    cp "$PACKDIR/server-icon.png" "$MCDIR/" 
    cp "$PACKDIR/minecraft@.service" /etc/systemd/system/
    log "Updated files on server"
else 
    log "Server files already on newest version"    
fi 
