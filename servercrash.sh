
SERVICE="ssh"
WEB_URL=$SLACK_WEBHOOK

STATUS=$(systemctl is-active $SERVICE)

if [ $"STATUS" != "active" ]; then
systemctl restart $SERVICE
RESTART_STATUS = $(systemctl is-active $SERVICE)

if [ $"RESTART_STATUS" == "active" ]; then

MESSAGE="✅ Service '$SERVICE' was DOWN and has been restarted successfully on $(hostname)"
  else
    MESSAGE="❌ CRITICAL: Service '$SERVICE' is DOWN and restart FAILED on $(hostname)"
fi
curl -X POST -sL -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE} .\"}" $WEB_URL

fi