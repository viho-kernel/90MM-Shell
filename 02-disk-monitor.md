# Disk Usage Monitoring and Log Cleanup Script

This repository contains a Bash script that monitors disk usage on a Linux system and automatically cleans up old log files when usage exceeds a defined threshold. It also sends an alert notification to a Slack channel.

---

## 📋 Features
- Monitors root (`/`) filesystem usage.
- Deletes `.log` files older than a specified number of days from `/var/log`.
- Sends a formatted alert message to Slack with:
  - Hostname
  - Disk usage before cleanup
  - Disk usage after cleanup
  - Timestamp

---

## ⚙️ Configuration
You can adjust the following variables inside the script:

- **`THRESHOLD`**: Disk usage percentage that triggers cleanup (default: `80`).
- **`LOG_DIR`**: Directory containing log files to clean (default: `/var/log`).
- **`DAYS`**: Age (in days) of log files to delete (default: `7`).
- **`SLACK_WEBHOOK`**: Environment variable containing your Slack webhook URL.  
  Example:
  ```bash
  export SLACK_WEBHOOK="https://hooks.slack.com/services/XXXX/YYYY/ZZZZ"
