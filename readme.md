# Dev Containers

This is my set of container images for use with [VS Code dev containers (aka VS Code Remote Containers)](https://code.visualstudio.com/docs/remote/containers), Codespaces and other uses such as runners for [nektos/act](https://github.com/nektos/act)

All images are built on base images from the "official" set of dev container definitions: https://github.com/microsoft/vscode-dev-containers

## Contents

Two versions of each image are available, one which runs as a non-root user and one which runs as root.

When working with VS Code dev containers the non-root version should be used, to prevent file ownership and permission issues.

| Runtime | Version | Non Root                                    | Root                                      |
| ------- | ------- | ------------------------------------------- | ----------------------------------------- |
| Node.js | 14.x    | ghcr.io/benc-uk/devcontainers/node:latest   | ghcr.io/benc-uk/devcontainers/node:root   |
| Go      | 1.16.x  | ghcr.io/benc-uk/devcontainers/go:latest     | ghcr.io/benc-uk/devcontainers/go:root     |
| Python  | 3.9     | ghcr.io/benc-uk/devcontainers/python:latest | ghcr.io/benc-uk/devcontainers/python:root |
| Dotnet  | 5.0     | ghcr.io/benc-uk/devcontainers/dotnet:latest | ghcr.io/benc-uk/devcontainers/dotnet:root |
| Java    | 11      | ghcr.io/benc-uk/devcontainers/java:latest   | ghcr.io/benc-uk/devcontainers/java:root   |

## Installed tools

The base images (from mcr<span>.microsoft.com/vscode/devcontainers) are all Debian based, with common packages already installed such as: jq, make, curl, wget, yarn, zsh, openssl, nettools, git

Extra tools and packages are installed via the `scripts/install.sh` script

This script clones the https://github.com/benc-uk/tools-install repo which is a set of Debian/Ubuntu install scripts for common tools, SDKs etc, and runs the install scripts from that repo

- Node.js
- Docker client
- Helm
- kubectl, kubectx & kubens
- Terraform
- Bicep
- GitHub CLI
- Azure CLI

## Using with nektos/act

Use the `root` images only when using with act
