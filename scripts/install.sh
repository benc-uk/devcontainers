#!/bin/bash

cd /tmp
git clone https://github.com/benc-uk/tools-install.git
mkdir -p $HOME/.local/bin

CODENAME=$(lsb_release -cs)
export DEBIAN_FRONTEND=noninteractive 

# Binary installed tools
./tools-install/docker-client.sh 
./tools-install/helm.sh 
./tools-install/kube-tools.sh 

# Add apt repos for kubectl, gh and azure-cli
curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.gpg
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $CODENAME main" > /etc/apt/sources.list.d/azure-cli.list
echo "deb https://cli.github.com/packages/ $CODENAME main" > /etc/apt/sources.list.d/github-cli.list

# Install kubectl gh azure-cli
apt-get update
apt-get install -y kubectl gh azure-cli

# Node installed as standard using nvm, Node used by so many things
\. "$NVM_DIR/nvm.sh"
nvm install --lts
