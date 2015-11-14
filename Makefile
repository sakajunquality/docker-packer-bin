VERSION=$(shell git  describe --tags --abbrev=0)
DOCKERHUB_REPO=sequenceiq/packer

deps:
	go get github.com/progrium/dockerhub-tag

build:
	docker build -t $(DOCKERHUB_REPO):$(VERSION) .

build-dev:
	docker build -t $(DOCKERHUB_REPO):dev .

dockerhub-tag:
	dockerhub-tag set $(DOCKERHUB_REPO) $(VERSION) $(VERSION) /

integration-test: build-dev
	docker run --rm sequenceiq/packer:dev version
