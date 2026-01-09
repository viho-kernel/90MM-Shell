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

# Define HOST and DATE
HOST=$(hostname)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

# Sys logs file
LOG_FILE="/var/log/syslog"
KEYWORDS="error|fail|critical|panic|successfully"

MATCHINGWORDS=$(grep -iE "$KEYWORDS" "$LOG_FILE" | tail -5)

if [ -n "$MATCHINGWORDS" ]; then
   MESSAGE="🚨 Log Alert on $HOST
File: $LOG_FILE
Time: $DATE
Last Errors:
$MATCHINGWORDS"

   curl -s -X POST -H 'Content-type: application/json' \
     --data "{\"text\":\"$MESSAGE\"}" "$SLACK_WEBHOOK_URL"
fi
