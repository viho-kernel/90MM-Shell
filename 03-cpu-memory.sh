#!/bin/bash

WEB_URL="https://hooks.slack.com/services/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"
### This script will explain us how to check the cpu utilization on your instance and memory.
### High cpu and memory will crash your systems
## HOW TO check and trigger the alerts in your slack channel

#Determining Threshold
CPU_THRESHOLD=5
MEM_THRESHOLD=5

### defining variables
HOST=$(hostname)
DATE=$(date)

###how to check cpu on your linux machine use "top -bn1"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
MEM_USAGE=$(free | awk ' NR==2 { print $3/$2 * 100}')

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ] || [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
  MESSAGE="⚠️ Resource Alert on $HOST
CPU Usage: ${CPU_USAGE}%
Memory Usage: ${MEM_USAGE}%
Time: $DATE"

  curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $WEB_URL
fi

