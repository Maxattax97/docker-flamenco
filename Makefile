.PHONY: all build run explore

build:
	docker build . -t flamenco-manager

run: build
	docker-compose rm -sf flamenco-manager
	docker-compose up flamenco-manager

explore: build
	docker run --rm -it flamenco-manager /bin/bash

all: run
