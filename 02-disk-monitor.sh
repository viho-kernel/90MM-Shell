#!/bin/bash

#WEB_URL="https://hooks.slack.com/services/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"

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
    --data "{\"text\":\"$MESSAGE\"}" $WEB_URL
fi