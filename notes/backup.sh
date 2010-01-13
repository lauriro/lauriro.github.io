#!/bin/bash
# Author: Lauri Rooden <lauri@neti.ee>

# Make sure we're running as root
# if [ `id -u` != 0 ]; then echo "You must be root to use this script";exit 1; fi

BACKUP_DIRS="/c/Code/yoga/rules /c/Code/yoga/web"
BACKUP_ROOT="/backup/"
EXCLUDES=".git/"
OPTS="-a --force --backup --stats --delete --delete-excluded"
# -z, --compress		    compress file data during the transfer

usage() {
	echo "Usage: $0 {make|compact|list|latest|restore [date]}"
	exit 1
}

# date +%Y/%m/%d/%X

case $1 in
    make)
		CURRENT=`date +%Y/%m/%d/%H%M%S`
		mkdir -p ${BACKUP_ROOT}$CURRENT

		for EXCLUDE in $EXCLUDES; do
			OPTS="$OPTS --exclude $EXCLUDE"
		done
		
		if [ -f ${BACKUP_ROOT}.latest ] ; then
			LATEST=${BACKUP_ROOT}`cat ${BACKUP_ROOT}/.latest`
			if [ -d $LATEST ] ; then
				#OPTS="$OPTS --backup-dir=$LATEST"
				OPTS="$OPTS --link-dest=$LATEST"
			fi
		fi

		for BACKUP_DIR in $BACKUP_DIRS; do
			if [ -d $BACKUP_DIR ] ; then
				rsync $OPTS $BACKUP_DIR ${BACKUP_ROOT}$CURRENT/
			else
				echo "ERROR: No such file or directory ($BACKUP_DIR)"
			fi
		done

		echo $CURRENT > "${BACKUP_ROOT}.latest"
    ;;
    
    compact)
        echo TODO
    ;;

    list)
        find ${BACKUP_ROOT} -mindepth 4 -maxdepth 4 -type d -print
    ;;

    latest)
		if [ -f ${BACKUP_ROOT}.latest ] ; then
			LATEST=${BACKUP_ROOT}`cat ${BACKUP_ROOT}.latest`
			if [ -d $LATEST ] ; then
				echo $LATEST
			fi
		fi
    ;;
    
    restore)
		if [ -z "$2" ] ; then
			BACKUPS=( )
			let i=0
			for BACKUP in $(find ${BACKUP_ROOT} -mindepth 4 -maxdepth 4 -type d | sort -r); do
				echo "$i) $BACKUP"
				BACKUPS[$i]=$BACKUP
				let "i = $i + 1"
			done
			echo -n "Enter the backup source (0-${#BACKUPS[@]-1}) or exit (x): "
			read opt
			if [ -z "$(echo $opt | tr -d 0-9)" ] ; then
				if [ -n "${BACKUPS[$opt]}" ] ; then
					SOURCE=${BACKUPS[$((0+$opt))]}
				else
					echo "ERROR: No such source"
					exit 1
				fi
			fi
		else
			SOURCE=$2
		fi

		if [ -n "$SOURCE" ] ; then
			echo restore source: $SOURCE
		
		fi

		
		
		#for BACKUP_DIR in $BACKUP_DIRS; do
		#	rsync -a --force ${BACKUP_ROOT}$SOURCE/${BACKUP_DIR##*/} ${BACKUP_DIR%/*}
		#done
    ;;
    
    *)
        usage
    ;;
esac

exit 0
# --exclude '.git' --exclude 'sources'
# rsync -e 'ssh -p 30000' -avl --delete --stats --progress --exclude-from '/home/backup/exclude.txt' demo@123.45.67.890:/home/demo /backup/
# rsync -e 'ssh -p 30000' -avl --delete --stats --progress --exclude 'sources' --exclude 'public_html/database.txt' demo@123.45.67.890:/home/demo /backup/