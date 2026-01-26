#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="./install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

sudo apt-get update
sudo apt upgrade　-y

# Install environment essentials
echo "========Installing environment essentials:========"
sudo apt install snapd curl wget gnupg unzip xz-utils zip libglu1-mesa -y
sudo systemctl enable snapd.service snapd.socket
. /etc/profile.d/apps-bin-path.sh
sudo systemctl start snapd.service snapd.socket

echo "========Installing Chrome:========"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb 

echo "========Installing Japanese Inputs:========"
sudo apt install -y ibus-mozc

# Install MS Editor
echo "========Installing snap store packages...========"
sudo snap install msedit localsend yazi ghostty --classic

# Install Development Tools
echo "========Installing Development Tools:========"

echo "========Installing Git...========"
sudo apt install git -y

echo "========Installing aws cli...========"
sudo snap install aws-cli --classic

echo "========Installing Docker...========"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install ca-certificates gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

echo "========Installing Ollama...========"
curl -fsSL https://ollama.com/install.sh | sh

echo "========Installing Kiro...========"
curl -fsSL https://cli.kiro.dev/install | bash

echo "========Installing Android Studio...========"
sudo snap install android-studio --classic

echo "========Installing terraform...========"
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform -y

# Install Databases
echo "========Installing Databases:========"

echo "========Installing Postgresql...========"
sudo apt install postgresql postgresql-client libpq-dev -y

echo "========Installing Redis...========"
sudo apt install redis redis-server -y

echo "========Installing Mongodb...========"
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
   --dearmor
echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# Install programming languages
echo "========Installing programming languages:========"

echo "========Installing Golang...========"
sudo snap install go --classic

echo "========Installing nodejs...========"
sudo apt install nodejs -y

echo "========Installing python3 and pip...========"
sudo apt install python3 python3-pip python3-venv -y

# Install npm/pnpm and packages
echo "========Installing npm/pnpm...========"
sudo apt install npm -y
sudo npm install pnpm -g
sudo pnpm setup　|| true
source ~/.bashrc

echo "========Installing typescript nodejs astro vite vitepress vuejs electron vercel gemini...========"
pnpm install -g typescript astro nodejs vite vitepress vue electron vercel @google/gemini-cli

# Install pip packages
echo "========Installing pip packages...========"
pip install virtualenv pandas numpy matplotlib flask requests

# Applying operstions
echo "========Applying operations:========"

echo "========Approve pnpm builds...========"
pnpm approve-builds -g

echo "========No sudo run Docker...========"
f getent group docker > /dev/null 2>&1; then
  echo "[INFO] docker group already exists"
else
  sudo groupadd docker
fi

if id -nG "$USER" | grep -qw docker; then
  echo "[INFO] user '$USER' is already in docker group"
else
  sudo usermod -aG docker "$USER"
fi

export PATH="$HOME/.local/bin:$PATH"
