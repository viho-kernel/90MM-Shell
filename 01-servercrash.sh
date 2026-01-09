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

SERVICE="ssh"

#checking whether service is active or not

STATUS=$(systemctl is-active $SERVICE)

if [ "$STATUS" != "active" ]; then
#if service is not active then restart it
systemctl restart $SERVICE
#check again after restarting
RESTART_STATUS=$(systemctl is-active $SERVICE)
 #if service is active then load a message failed load one more message
if [ "$RESTART_STATUS" == "active" ]; then

MESSAGE="✅ Service '$SERVICE' was DOWN and has been restarted successfully on $(hostname)"
  else
    MESSAGE="❌ CRITICAL: Service '$SERVICE' is DOWN and restart FAILED on $(hostname)"
fi
curl -X POST -sL -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE} .\"}" $SLACK_WEBHOOK_URL

fi