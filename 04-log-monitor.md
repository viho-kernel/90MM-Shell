-z STRING → True if string length is zero (empty).

-n STRING → True if string length is non‑zero.

-e FILE → True if file exists.

-f FILE → True if file exists and is a regular file.

-d DIR → True if directory exists.

-r FILE → True if file is readable.

-w FILE → True if file is writable.

-x FILE → True if file is executable.

# System Log Monitoring & Slack Alerts

This Bash script monitors **system logs** (`/var/log/syslog`) for critical keywords and sends alerts to a configured **Slack channel** when matches are found. It helps teams stay informed about important events such as errors, failures, or critical system messages.

---

## 📌 Features
- Monitors `/var/log/syslog` for specific keywords.
- Supports multiple keywords using extended regex (`error|fail|critical|panic|successfully`).
- Case‑insensitive search (`-i`).
- Captures the **last 5 matching log entries**.
- Sends formatted alerts to Slack via **Incoming Webhook**.
- Includes file name, timestamp, and matched log lines in the alert.

---

## ⚙️ Configuration

### 1. Log File
By default, the script monitors:
```bash
LOG_FILE="/var/log/syslog"
