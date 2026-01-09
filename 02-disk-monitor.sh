#!/bin/bash

set -euo pipefail


CONFIG_FILE="$(dirname "$0")/config.env" 
if [ -f "$CONFIG_FILE" ]; then
source "$CONFIG_FILE" 
fi 
# Fail fast if variable not set 
if [ -z "${SLACK_WEBHOOK_URL:-}" ]; then 
echo "Error: SLACK_WEBHOOK_URL not set. Please create config.env or export it in your environment." 
exit 1 
fi


THRESHOLD=20
LOG_DIR="/var/log"
DAYS=7

HOST=$(hostname)

DATE=$(date)

#disk space is checked using df -h

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -ge "$THRESHOLD" ]; then

   BEFORE=$(df -h / | awk 'NR==2 {print $5}' )

   find $LOG_DIR -type f -name "*.log" -mtime +$DAYS -delete

   AFTER=$(df -h / | awk 'NR==2 {print $5}' )

   MESSAGE="Disk usage alert on $HOST after cleanup is $AFTER"

   echo "Before cleanup: $BEFORE" echo "After cleanup: $AFTER" echo "Time: $DATE" echo "$MESSAGE"

   curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $SLACK_WEBHOOK_URL
fi