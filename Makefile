HOST_MNT = /opt/devpicache
PORTS = -p 3141:3141
CID_FILE = /tmp/docker-devpi.cid
IMAGE_NAME = grokzen/devpi
CID =`cat $(CID_FILE)`

help:
	@echo "Please use 'make <target>' where <target> is one of"
	@echo "  configure-client        Configure your local client to use devpi inside the docer container"
	@echo "  docker-build            build the docker container"
	@echo "  docker-rebuild          rebuilds the entire image without any cached layers"
	@echo "  docker-run              start the docker container and supervisord in foreground [default mode to use]"
	@echo "  docker-run-i            start 'bash' in the docker container. Will not start supervisord / nginx / devpi-server"
	@echo "  docker-run-d            start the docker container in background/daemon mode"
	@echo "  docker-stop             stop a running container (interactive and daemon)"

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-rebuild:
	docker build --no-cache=true -t $(IMAGE_NAME)

docker-run:
	docker run -v $(HOST_MNT):/opt/devpi -it $(PORTS) $(IMAGE_NAME)

docker-run-i:
	docker run -v $(HOST_MNT):/opt/devpi -it $(PORTS) $(IMAGE_NAME) /bin/bash

docker-run-d:
	docker run --cidfile=$(CID_FILE) -v $(HOST_MNT):/opt/devpi -d $(PORTS) $(IMAGE_NAME)

docker-stop:
	# Stop any existing containers
	-docker stop $(CID)
	make clean

clean:
	# Cleanup cidfile on disk
	-rm $(CID_FILE)
