#!/bin/bash

#Take backup's and verify

SOURCE_DIR="/etc"
BACKUP_DIR="/backup"
LOG_FILE="/var/log/backup.log"
DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_FILE="$BACKUP_DIR/etc-backup-$DATE.tar.gz"

mkdir -p $BACKUP_DIR

mkdir -p $LOG_FILE

echo "[$(date)] Backup started" >> $LOG_FILE

tar -czf $BACKUP_FILE $SOURCE_DIR 2>> $LOG_FILE

if [ $? -ne 0 ]; then
   echo "[$(date)] Backup FAILED" >> $LOG_FILE
   exit 1

fi 

tar -tzf $BACKUP_FILE > /dev/null 2>&1

if [ $? -eq 0 ]; then
   echo "[$(date)] Backup SUCCESS & VERIFIED: $BACKUP_FILE" >> $LOG_FILE
else
  echo "[$(date)] Backup created but verification FAILED" >> $LOG_FILE
  exit 2
fi
