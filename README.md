# 🔗 Connecting an Ubuntu VM to GitHub with SSH

This guide explains how to configure an Ubuntu virtual machine (VM) to connect securely to GitHub using SSH keys. Once set up, you can clone, pull, and push repositories without entering your username or personal access token each time.

---

## 🛠 Steps to Connect Ubuntu VM to GitHub

### 1. Install Git
Make sure Git is installed on your VM:
```bash
sudo apt update
sudo apt install git -y


Set your GitHub username and email:

bash
git config --global user.name "your-github-username"
git config --global user.email "your-email@example.com"

Generate an SSH Key
Create a new SSH key pair for the ubuntu user:

bash
ssh-keygen -t ed25519 -C "your-email@example.com"

. Add Key to SSH Agent
Start the agent and add your private key:

bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

Add Public Key to GitHub
Copy your public key:

bash
cat ~/.ssh/id_ed25519.pub

Go to GitHub → Settings → SSH and GPG keys → New SSH key.

Paste the key and save.

6. Test Connection
Verify that GitHub recognizes your key:

bash
ssh -T git@github.com

Expected output:

Hi your-github-username! You've successfully authenticated, but GitHub does not provide shell access.

7. Clone a Repository
Use the SSH URL instead of HTTPS:

git clone git@github.com:your-github-username/your-repo.git
cd your-repo

Push and Pull
Now you can work normally:

git add .
git commit -m "Your commit message"
git push origin main
git pull origin main
