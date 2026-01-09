#!/bin/bash

set -euo pipefail


CONFIG_FILE="$(dirname "$0")/config.env" 
if [ -f "$CONFIG_FILE" ]; then 
# shellcheck disable=SC1090 
source "$CONFIG_FILE" 
fi 
# Fail fast if variable not set 
if [ -z "${SLACK_WEBHOOK_URL:-}" ]; then 
echo "Error: SLACK_WEBHOOK_URL not set. Please create config.env or export it in your environment." 
exit 1 
fi

#Determining Threshold
CPU_THRESHOLD=5 
MEM_THRESHOLD=5

### defining variables
HOST=$(hostname)
DATE=$(date)

###how to check cpu on your linux machine use "top -bn1"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1) 
MEM_USAGE=$(free | awk 'NR==2 {print $3/$2 * 100}' | cut -d. -f1)

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ] || [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
  MESSAGE="⚠️ Resource Alert on $HOST
CPU Usage: ${CPU_USAGE}%
Memory Usage: ${MEM_USAGE}%
Time: $DATE"

  curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $SLACK_WEBHOOK_URL
fi



