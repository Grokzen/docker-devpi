HOST_MNT = /opt/devpicache
PORTS = -p 3141:3141
CID_FILE = /tmp/docker-devpi.cid
IMAGE_NAME = grokzen/devpi
CID =`cat $(CID_FILE)`

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  build            build the docker container"
	@echo "  rebuild          rebuilds the entire image without any cached layers"
	@echo "  run              start the docker container and supervisord in foreground [default mode to use]"
	@echo "  run-i            start 'bash' in the docker container. Will not start supervisord / nginx / devpi-server"
	@echo "  run-d            start the docker container in background/daemon mode"
	@echo "  stop             stop a running container (interactive and daemon)"

build:
	docker build -t $(IMAGE_NAME) .

rebuild:
	docker build --no-cache=true -t $(IMAGE_NAME)

run:
	docker run -v $(HOST_MNT):/opt/devpi -it $(PORTS) $(IMAGE_NAME)

run-i:
	docker run -v $(HOST_MNT):/opt/devpi -it $(PORTS) $(IMAGE_NAME) /bin/bash

run-d:
	docker run --cidfile=$(CID_FILE) -v $(HOST_MNT):/opt/devpi -d $(PORTS) $(IMAGE_NAME)

stop:
	# Stop any existing containers
	-docker stop $(CID)
	-make clean

clean:
	# Cleanup cidfile on disk
	-rm $(CID_FILE)
