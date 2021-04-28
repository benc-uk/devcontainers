# Defaults
IMAGE_REG ?= ghcr.io
IMAGE_REPO ?= benc-uk/devcontainers
IMAGE_NAME ?= go
IMAGE_TAG ?= latest
IMAGE_BASE ?= mcr.microsoft.com/vscode/devcontainers/go:1.16
IMAGE_USER ?= vscode
IMAGE_USERHOME ?= /home/vscode

.PHONY: image push node node-root go python dotnet java

image:
	docker build . --file Dockerfile \
	--tag $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) \
	--build-arg BASE=$(IMAGE_BASE) --build-arg user=$(IMAGE_USER) --build-arg userhome=$(IMAGE_USERHOME)

push:
	docker push $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

# The base image doesn't use vscode as a non-root user, which is a fricken pain in the bum
node:
	make image IMAGE_NAME=node IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/javascript-node:14 IMAGE_USER=node IMAGE_USERHOME=/home/node

# So we need this special case for the node root image, arrrgh
node-root:
	make image IMAGE_NAME=node IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/javascript-node:14 IMAGE_USER=root IMAGE_USERHOME=/root IMAGE_TAG=root

go:
	make image IMAGE_NAME=go IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/go:1.16

python:
	make image IMAGE_NAME=python IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/python:3.9

dotnet:
	make image IMAGE_NAME=dotnet IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/dotnetcore:5.0

java:
	make image IMAGE_NAME=java IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/java:11
