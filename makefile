# Defaults
IMAGE_REG ?= ghcr.io
IMAGE_REPO ?= benc-uk/devcontainers
IMAGE_NAME ?= go
IMAGE_TAG ?= latest
IMAGE_BASE ?= mcr.microsoft.com/vscode/devcontainers/go:1.16
IMAGE_USER ?= vscode
IMAGE_USERHOME ?= /home/vscode

# Base images
NODE_BASE := mcr.microsoft.com/vscode/devcontainers/javascript-node:14
GO_BASE := mcr.microsoft.com/vscode/devcontainers/go:1.16
PYHTON_BASE := mcr.microsoft.com/vscode/devcontainers/python:3.9
DOTNET_BASE := mcr.microsoft.com/vscode/devcontainers/dotnetcore:5.0
JAVA_BASE := mcr.microsoft.com/vscode/devcontainers/java:11

# This junk is needed because the javascript base image uses 'node' not 'vscode' as non-root user
ifeq ($(IMAGE_NAME),node)
    IMAGE_USER := node
		IMAGE_USERHOME := /home/node
endif

.PHONY: image push node node-root go python dotnet java

image:
	docker build . --file Dockerfile \
	--tag $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG) \
	--build-arg baseImage=$(IMAGE_BASE) \
	--build-arg user=$(IMAGE_USER) \
	--build-arg userhome=$(IMAGE_USERHOME)

push:
	docker push $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

node:
	make image IMAGE_NAME=node IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/javascript-node:14

go:
	make image IMAGE_NAME=go IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/go:1.16

python:
	make image IMAGE_NAME=python IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/python:3.9

dotnet:
	make image IMAGE_NAME=dotnet IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/dotnetcore:5.0

java:
	make image IMAGE_NAME=java IMAGE_BASE=mcr.microsoft.com/vscode/devcontainers/java:11
