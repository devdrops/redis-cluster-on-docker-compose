# ----------------------------------------------------------------------------------------------------------------------
# Variables and arguments
# ----------------------------------------------------------------------------------------------------------------------
SHELL := '/bin/bash'

run-bitnami-cluster:
	docker rm -f redis-bitnami-cluster
	docker run -ti --name redis-bitnami-cluster \
		-v $(PWD)/bitnami:/bitnami \
		-e ALLOW_EMPTY_PASSWORD=yes \
		-e REDIS_NODES="" \
		bitnami/redis-cluster:latest

create-conf:
	$(shell ./create-redis-conf.sh)

run-cluster:
