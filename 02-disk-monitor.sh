#!/bin/bash

WEB_URL="https://hooks.slack.com/services/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"

THRESHOLD=80
LOG_DIR="/var/log"
DAYS=7

HOST=$(hostname)

DATE=$(date)

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -ge "$THRESHOLD" ]; then

   BEFORE=$(df -h / | awk 'NR==2 {print $5}' )

   find $LOG_DIR -type f -name "*.log" -mtime +$DAYS -delete

   AFTER=$(df -h / | awk 'NR==2 {print $5}' )

   MESSAGE="Disk usage alert on $HOST"

   Before cleanup: $BEFORE
   AFTER cleanup: $AFTER

   TIME: $(date)

   curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $WEB_URL
fi