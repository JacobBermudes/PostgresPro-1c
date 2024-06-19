#!/bin/bash
set -e

# Set defaults for configuration variables
BINDIR=/opt/pgpro/1c-15/bin
PGDATA=/var/lib/pgpro/1c-15/data
PG_OOM_ADJUST_VALUE=0
PG_OOM_ADJUST_FILE=/proc/self/oom_score_adj
export PG_OOM_ADJUST_FILE PG_OOM_ADJUST_VALUE
export PG_OOM_AJUST_VALUE
PGLOG="$(dirname "$PGDATA")/pgstartup-$(basename "$PGDATA").log"

init_db(){
    if [[ -n $PG_PASSWORD ]]; then
        echo "${PG_PASSWORD}" > /tmp/pwfile
    else
        echo "JacobBermudes" > /tmp/pwfile ### DEFAULT PASSWORD
        echo -e "\e[31mDEFAULT PASSWORD WAS USED!!! MOST IMPORTANT TO CHANGE TO YOUR PRIVITE PASSOWRD!\e[0m"
    fi

    rm -rf "${PGDATA}/*"
    chown postgres $PGDATA

    su -l postgres -c "initdb --pgdata=${PGDATA} \
        --encoding=unicode \
        --locale=ru_RU.UTF-8 \
        --auth=trust \
        --pwfile=/tmp/pwfile"    
}


start_cluster(){
    echo "Starting cluster daemon for PostgresPro 1C Edition..."

    su -l postgres -c "${BINDIR}/check-db-dir $PGDATA" ## set -e is stalking the returned code

    su -l postgres -c "PG_OOM_ADJUST_FILE=-1000 PG_OOM_ADJUST_VALUE=$PG_OOM_ADJUST_VALUE _ADJPATH=/opt/pgpro/1c-15/bin:/usr/bin:/usr/sbin:/bin:/sbin ${BINDIR}/postgres -D '$PGDATA' "
}

if ! [[ -z ${1} ]]; then
    
    echo "Starting container for PostgresPro 15 1C Edition..."

    if [[ -z $(ls -A "$PGDATA") ]]; then
        echo "Initializing cluster..."
        init_db
    else
        echo "Cluster was found. Skipping init..."
    fi

    start_cluster

fi

