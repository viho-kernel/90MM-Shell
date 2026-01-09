#!/bin/bash
#shebang

#sys logs files are saved here
LOG_FILE="/var/log/syslog"
KEYWORDS="error|fail|critical|panic|successfully"

#WEB_URL="https://hooks.slack.com/services/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"

MATCHINGWORDS=$(grep -iE "$KEYWORDS" $LOG_FILE | tail -5)

if [ ! -z "$MATCHINGWORDS" ]; then

   MESSAGE="🚨 Log Alert on $HOST
File: $LOG_FILE
Time: $DATE
Last Errors:
$MATCHINGWORDS"

  curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $WEB_URL
fi