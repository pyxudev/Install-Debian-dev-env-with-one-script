sudo apt-get update
sudo apt upgrade

# Install environment essentials
echo "========Installing environment essentials:========"
sudo apt install snapd curl unzip xz-utils zip libglu1-mesa -y
sudo systemctl enable snapd.service snapd.socket
sudo source /etc/profile.d/apps-bin-path.sh
sudo systemctl start snapd.service snapd.socket

# Install MS Editor
echo "========Installing MS Editor...========"
sudo snap install msedit -y

# Install Development Tools
echo "========Installing Development Tools:========"

echo "========Installing Git...========"
sudo apt install git -y

echo "========Installing aws cli...========"
sudo snap install aws-cli --classic -y

echo "========Installing Docker...========"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install ca-certificates gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
echo "========No sudo run Docker...========"
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

echo "========Installing Android Studio...========"
sudo snap install android-studio --classic -y

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
sudo apt install postgresql redis-server mongodb mysql-server mysql-client -y

# Install programming languages
echo "========Installing programming languages:========"
echo "========Installing Golang...========"
sudo snap install go --classic -y

echo "========Installing nodejs...========"
sudo apt install nodejs -y

echo "========Installing python3 and pip...========"
sudo apt install python3 python3-pip python3-venv -y

# Install npm/pnpm and packages
echo "========Installing npm/pnpm...========"
sudo apt install npm -y
sudo npm install pnpm -g
echo "========Installing typescript nodejs astro vite vitepress vuejs electron vercel gemini...========"
pnpm install -g typescript astro nodejs vite vitepress vue electron vercel @google/gemini-cli

pnpm approve-builds -g

# Install pip packages
echo "========Installing pip packages:========"
pip install virtualenv pandas numpy matplotlib flask requests