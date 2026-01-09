#!/bin/bash
#shebang

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

#sys logs files are saved here
LOG_FILE="/var/log/syslog"
KEYWORDS="error|fail|critical|panic|successfully"

#WEB_URL="https://hooks.slack.com/services/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"

MATCHINGWORDS=$(grep -iE "$KEYWORDS" $LOG_FILE | tail -5)

if [ ! -z "$MATCHINGWORDS" ]; then

   MESSAGE="🚨 Log Alert on $HOST
File: $LOG_FILE
Time: $DATE
Last Errors: $MATCHINGWORDS

  curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $SLACK_WEBHOOK_URL "
fi