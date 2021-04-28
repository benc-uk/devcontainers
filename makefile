# Defaults
IMAGE_REG ?= ghcr.io
IMAGE_REPO ?= benc-uk/devcontainers
IMAGE_NAME ?= go
IMAGE_TAG ?= latest
IMAGE_BASE ?= mcr.microsoft.com/vscode/devcontainers/go:1.16
IMAGE_USER ?= vscode
IMAGE_USERHOME ?= /home/vscode

.PHONY: image push node go python dotnet java push-all
.DEFAULT_GOAL := help

help:  ## 💬 This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

image:  ## 🔨 Build container image from Dockerfile 
	docker build . --file Dockerfile \
	--tag $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) \
	--build-arg BASE=$(IMAGE_BASE) --build-arg user=$(IMAGE_USER) --build-arg userhome=$(IMAGE_USERHOME)

push:  ## 📤 Push container image to registry 
	docker push $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

node:
	make image IMAGE_NAME=node IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/javascript-node:14 IMAGE_USER=node IMAGE_USERHOME=/home/node

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
