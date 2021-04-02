#!/bin/bash

cd /tmp
git clone https://github.com/benc-uk/tools-install.git
mkdir -p $HOME/.local/bin

# Install away!
apt-get update && apt-get install -y software-properties-common
./tools-install/azure-cli.sh
./tools-install/docker-client.sh 
./tools-install/helm.sh 
./tools-install/kubectl.sh 
./tools-install/kube-tools.sh 
./tools-install/gh.sh

rm -rf ./tools-install