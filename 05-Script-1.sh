#!/bin/bash
#tells linux which interpreter should run this script.


SOURCE_DIR="/etc" #This is the data we want to backup it contains service configs, users and sudo rules
BACKUP_DIR="/backup" #central place to store all the backups
LOG_FILE="/var/log/backup.log" #logs
DATE=$(date +"%Y-%m-%d_%H-%M") #adding timestamp
BACKUP_FILE="$BACKUP_DIR/etc-backup-$DATE.tar.gz" #full backup file name with source and time

mkdir -p $BACKUP_DIR

echo "[$(date)] Backup started" >> $LOG_FILE

tar -czf $BACKUP_FILE $SOURCE_DIR 2>> $LOG_FILE # -czf -c create archive/ -z gzip compression/ -f filename 

if [ $? -ne 0 ]; then
   echo "[$(date)] Backup FAILED" >> $LOG_FILE
   exit 1

fi 

tar -tzf $BACKUP_FILE > /dev/null 2>&1 # -tzf -t list archive contents 

if [ $? -eq 0 ]; then
   echo "[$(date)] Backup SUCCESS & VERIFIED: $BACKUP_FILE" >> $LOG_FILE
else
  echo "[$(date)] Backup created but verification FAILED" >> $LOG_FILE
  exit 2
fi
