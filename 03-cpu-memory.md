Here’s the full **README.md** consolidated into a single page so you can copy‑paste directly:

```markdown
# CPU & Memory Monitoring Script

This Bash script monitors **CPU** and **memory utilization** on a Linux instance and sends alerts to a configured **Slack channel** when usage exceeds defined thresholds.

---

## 📌 Features
- Monitors CPU usage using `top`.
- Monitors memory usage using `free`.
- Compares usage against configurable thresholds.
- Sends alerts to Slack via **Incoming Webhook**.
- Includes hostname and timestamp in alerts for easy identification.

---

## ⚙️ Configuration

### 1. Slack Webhook URL
Replace the placeholder in the script with your Slack Incoming Webhook URL:
```bash
WEB_URL="https://hooks.slack.com/services/XXXX/YYYY/ZZZZ"
```

### 2. Thresholds
Set CPU and memory thresholds (percentage values):
```bash
CPU_THRESHOLD=5
MEM_THRESHOLD=5
```
> Example: If CPU usage ≥ 5% or Memory usage ≥ 5%, an alert will be triggered.

---

## 🚀 Usage

1. Save the script as `cpu-memory-monitor.sh`.
2. Make it executable:
   ```bash
   chmod +x cpu-memory-monitor.sh
   ```
3. Run manually:
   ```bash
   ./cpu-memory-monitor.sh
   ```
4. (Optional) Schedule via **cron** for continuous monitoring:
   ```bash
   */5 * * * * /path/to/cpu-memory-monitor.sh
   ```
   This runs the script every 5 minutes.

---

## 📤 Example Alert

When thresholds are exceeded, a Slack message will look like:

```
⚠️ Resource Alert on ip-172-31-20-102
CPU Usage: 16%
Memory Usage: 12%
Time: Sun Jan 4 22:34:00 IST 2026
```

---

## 🛠️ Dependencies
- `bash`
- `top`
- `free`
- `curl`

These are available by default on most Linux distributions.

---

## 🔒 Notes
- Ensure your Slack webhook URL is kept **secure** and not committed to public repositories.
- Adjust thresholds based on workload requirements.
- For more precise floating‑point comparisons, consider using `bc` instead of rounding with `cut`.

---

## 📚 References
- [Slack Incoming Webhooks Documentation](https://api.slack.com/messaging/webhooks)
- Linux `top` and `free` man pages
```

This is now a **single, copy‑ready README.md** file you can drop straight into your repo.
