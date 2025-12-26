#Day-1' Linux Service Monitoring with Slack Alert 
In real-world DevOps and Cloud environments, critical services going down can cause incidents, outages, or SLA breaches.  
This script continuously monitors a Linux service and performs **self-healing** by restarting the service if it is found down.  
It also sends a **Slack alert** to notify the team about the incident and recovery status.


---

## 🎯 Use Case (Real-Time Scenario)
- A critical service (SSH, Nginx, Docker, Jenkins, etc.) crashes unexpectedly
- The server is still reachable but the service is unavailable
- Immediate restart is required
- Team must be notified via Slack for visibility and auditing

---

## 🛠 Tools & Technologies Used
- **Linux (systemd)**
- **Bash scripting**
- **Slack Incoming Webhooks**
- **Environment variables for secret management**

---

## 📂 Files Involved
```text
01-servercrash.sh   -> Main monitoring and self-healing script
01-servercrash.md   -> Documentation for the script
urls.env            -> Stores Slack webhook URL (NOT committed to Git)
.gitignore          -> Prevents secrets from being tracked