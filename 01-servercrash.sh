#!/bin/bash

SERVICE="ssh"
WEB_URL="https://hooks.slack.com/services/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"

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
curl -X POST -sL -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE} .\"}" $WEB_URL

fi