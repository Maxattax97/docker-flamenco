.PHONY: all build run explore-manager explore-worker publish

build:
	docker build . -f Dockerfile.manager -t flamenco-manager
	#docker build . -f Dockerfile.worker -t flamenco-worker

run: build
	docker-compose rm -sf
	docker volume rm docker-flamenco_nfs-flamenco
	docker-compose up

explore-manager:
	docker run --rm -it flamenco-manager /bin/bash

explore-worker:
	docker run --rm -it flamenco-worker /bin/bash

all: run

publish:
	docker tag flamenco-manager maxattax/flamenco-manager
	docker push maxattax/flamenco-manager
	#docker tag flamenco-worker maxattax/flamenco-worker
	#docker push maxattax/flamenco-worker
