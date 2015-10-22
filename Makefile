VERSION=0.8.7
DOCKERHUB_REPO=sequenceiq/packer

deps:
	go get github.com/progrium/dockerhub-tag

build:
	docker build -t $(DOCKERHUB_REPO):$(VERSION) .

build-dev:
	docker build -t $(DOCKERHUB_REPO):dev .

dockerhub-tag:
	dockerhub-tag set $(DOCKERHUB_REPO) 0.8.7-mock master /

integration-test: build-dev
	docker run --rm sequenceiq/packer:dev version
