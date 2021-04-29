#!/bin/bash

# Grab my install script repo
cd /tmp || true
git clone https://github.com/benc-uk/tools-install.git

CODENAME=$(lsb_release -cs)
NODE_VERSION=node_14.x
# Have to fix terraform version as latest release on GitHub can be older version
TERRAFORM_VERSION=0.15.1
export DEBIAN_FRONTEND=noninteractive 

# Tools installed as simple binaries, without apt
./tools-install/docker-client.sh 
./tools-install/helm.sh 
./tools-install/kube-tools.sh 
./tools-install/terraform.sh $TERRAFORM_VERSION
./tools-install/bicep.sh 
./tools-install/kubectl.sh 
./tools-install/gh.sh 

# Add apt repo for Azure CLI
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $CODENAME main" | sudo tee /etc/apt/sources.list.d/azure-cli.list

# Add apt repo for Node.js
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
echo "deb https://deb.nodesource.com/$NODE_VERSION $CODENAME main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$NODE_VERSION $CODENAME main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list

# Install Azure CLI and Node.js, make is missing from some base images
sudo apt-get update -qq
sudo apt-get install -y azure-cli nodejs make

# Update NPM and allow NPM to work without root/sudo
# This is done as using nvm caused some issues
mkdir -p "$HOME/.npm-global"
npm config set prefix "$HOME/.npm-global"
npm install -g npm
