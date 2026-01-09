#!/bin/bash

#WEB_URL="https://hooks.slack.com/services/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"

REPORT="/tmp/system-health.txt"
DATE=$(date)
HOST=$(hostname)
STATUS="OK"

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}' | cut -d. -f1) 
MEM=$(free | awk 'NR==2 {print $3/$2 * 100}' | cut -d. -f1)
DISK=$(df / | awk 'NR==2 {print $5}' | cut -d% -f1)

echo "System Health Report - $DATE" > $REPORT
echo "Host: $HOST" >> $REPORT
echo "CPU Usage: $CPU%" >> $REPORT
echo "Memory Usage: $MEM%" >> $REPORT
echo "Disk Usage: $DISK%" >> $REPORT

if [ "$CPU" -ge 10 ] || [ "$MEM" -ge 5 ] || [ "$DISK" -ge 12 ]; then
  STATUS="NOT_OK"
fi

if [ "$STATUS" = "NOT_OK" ]; then
  curl -X POST -sL -H 'Content-type: application/json' --data "{\"text\":\"🚨 System Health ALERT on $HOST\n$(cat $REPORT)\"}" $WEB_URL

fi