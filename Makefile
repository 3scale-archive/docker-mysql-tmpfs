REPO=mysql-tmpfs
TAG=$(shell git rev-parse --abbrev-ref HEAD)
REGISTRY=quay.io/3scale/
IMAGE=$(REGISTRY)$(REPO):$(TAG)
RUN:=docker run --privileged

build:
	docker build -t $(IMAGE) --rm .
bash:
	$(RUN) -it --rm $(IMAGE) bash
release: build push

test: build
	- docker rm --force mysql_tmpfs_test 2> /dev/null
	$(RUN) -it --name mysql_tmpfs_test --detach $(IMAGE) sleep 10
	docker exec mysql_tmpfs_test /mysql/run
push:
	docker push $(IMAGE)
