# ----------------------------------------------------------------------------------------------------------------------
# Variables and arguments
# ----------------------------------------------------------------------------------------------------------------------
SHELL := '/bin/bash'

create-conf:
	$(shell ./create-redis-conf.sh)

run-redis:
	docker compose up

create-cluster:
	docker compose exec redis-0 bash
