#!/usr/bin/sh
docker stack ls --format "{{.Name}}" | grep aplgo | grep -v master | xargs docker stack rm
docker system prune --volumes --force --all
