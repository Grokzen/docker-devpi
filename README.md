# Devpi Dockerfile

Dockerfile for running devpi in a container.



## Dependencies

- docker >= 1.2 installed



## Installation

Open `Makefile` and edit the following variables to make them compatible with your system.

 - HOST_MNT = /opt/devpicache
 - CID_FILE = "/tmp/docker-devpi.cid"
 - IMAGE_NAME = grokzen/devpi

The folder that `HOST_MNT` points to must exist before building and running the image, otherwise data will not be persisted between runs.

To build the image run `make docker-build`.

To rebuild the entire image from scratch run `make docker-rebuild`



## Usage

There is 3 options to start the container.

 - `make docker-run` will start `devpi-server` and run it in the foreground.
 - `make docker-run-i` will not start `devpi-server` but start `/bin/bash` inside the container
 - `make docker-run-d` will start `devpi-server` in the background. Default mode when everything is working.

Devpi creates a user named `root` with empty password by default.

To stop a container that is started as a daemon you must run `make docker-stop`. It will stop the image and remove the cid file from disk. It will not be possible to start the image x2 times if the cid file is still present.
