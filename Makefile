.PHONY: all build run explore-manager explore-worker

build:
	docker build . -f Dockerfile.manager -t flamenco-manager
	docker build . -f Dockerfile.worker -t flamenco-worker

run: build
	docker-compose rm -sf flamenco-manager flamenco-worker
	docker-compose up

explore-manager:
	docker run --rm -it flamenco-manager /bin/bash

explore-worker:
	docker run --rm -it flamenco-worker /bin/bash

all: run
