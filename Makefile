REPO=mysql-tmpfs
TAG=$(shell git rev-parse --abbrev-ref HEAD)
IMAGE=$(REPO):$(TAG)
REGISTRY=quay.io/3scale/

build:
	docker build -t $(REGISTRY)$(IMAGE) --rm .
bash:
	docker run --rm --privileged -t -i $(REGISTRY)$(IMAGE) bash
release: build push

push:
	docker tag $(TAG) $(REGISTRY)$(IMAGE)
	docker push $(REGISTRY)$(IMAGE)
