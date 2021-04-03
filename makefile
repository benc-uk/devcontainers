IMAGE_REG ?= ghcr.io
IMAGE_REPO ?= benc-uk/devcontainers
IMAGE_NAME ?= node
IMAGE_TAG ?= latest

# List of all images
IMAGES := node go dotnet python

.PHONY: image image-all push push-all
.DEFAULT_GOAL := help

help:  ## 💬 This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

image:  ## 🔨 Build container image from Dockerfile 
	docker build . --file $(IMAGE_NAME).Dockerfile \
	--tag $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

push:  ## 📤 Push container image to registry 
	docker push $(IMAGE_REG)/$(IMAGE_REPO)/$(IMAGE_NAME):$(IMAGE_TAG)

image-all:  ## 🔨 Build ALL container images
	for IMG in $(IMAGES) ; do \
		make image IMAGE_NAME=$$IMG; \
	done

push-all:  ## 📤 Push ALL container images to registry 
	for IMG in $(IMAGES) ; do \
		make push IMAGE_NAME=$$IMG; \
	done