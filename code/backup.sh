#!/bin/bash
# Author: Lauri Rooden <lauri@neti.ee>

# Make sure we're running as root
# if [ `id -u` != 0 ]; then echo "You must be root to use this script";exit 1; fi

BACKUP_DIRS="/c/Code/yoga/rules /c/Code/yoga/web"
BACKUP_ROOT="/backup"
EXCLUDES=".git/"
OPTS="-a --force --backup --stats --delete --delete-excluded"
# -z, --compress		    compress file data during the transfer

list() {
	ls -la
}

# date +%Y/%m/%d/%X

case "$1" in
    "make")
		CURRENT=`date +%Y/%m/%d/%H%M%S`
		mkdir -p ${BACKUP_ROOT}/$CURRENT

		for EXCLUDE in $EXCLUDES; do
			OPTS="$OPTS --exclude $EXCLUDE"
		done
		
		if [ -f ${BACKUP_ROOT}/.latest ] ; then
			LATEST=${BACKUP_ROOT}/`cat ${BACKUP_ROOT}/.latest`
			if [ -d $LATEST ] ; then
				#OPTS="$OPTS --backup-dir=$LATEST"
				OPTS="$OPTS --link-dest=$LATEST"
			fi
		fi

		for BACKUP_DIR in $BACKUP_DIRS; do
			if [ -d $BACKUP_DIR ] ; then
				rsync $OPTS $BACKUP_DIR ${BACKUP_ROOT}/$CURRENT/
			else
				echo "ERROR: No such file or directory ($BACKUP_DIR)"
			fi
		done

		echo $CURRENT > "${BACKUP_ROOT}/.latest"
    ;;
    
    "compact")
        echo TODO
    ;;

    "list")
        find ${BACKUP_ROOT} -mindepth 4 -maxdepth 4 -type d -print
    ;;

    "latest")
		if [ -f ${BACKUP_ROOT}/.latest ] ; then
			LATEST=${BACKUP_ROOT}/`cat ${BACKUP_ROOT}/.latest`
			if [ -d $LATEST ] ; then
				echo $LATEST
			fi
		fi
    ;;
    
    "restore")
		DATE=$2
		for BACKUP_DIR in $BACKUP_DIRS; do
			rsync -a --force ${BACKUP_ROOT}/$DATE/${BACKUP_DIR##*/} ${BACKUP_DIR%/*}
		done
    ;;
    
    *)
        echo "Usage: $0 {make|compact|list|latest|restore [date]}"
        exit 1
    ;;
esac

# --exclude '.git' --exclude 'sources'
# rsync -e 'ssh -p 30000' -avl --delete --stats --progress --exclude-from '/home/backup/exclude.txt' demo@123.45.67.890:/home/demo /backup/
# rsync -e 'ssh -p 30000' -avl --delete --stats --progress --exclude 'sources' --exclude 'public_html/database.txt' demo@123.45.67.890:/home/demo /backup/