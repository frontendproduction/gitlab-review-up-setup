#!/bin/bash
docker run -d \
    --name gitlab-runner \
    --restart always \
    -v gitlab-runner:/etc/gitlab-runner \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v /usr/bin/docker:/usr/bin/docker \
    gitlab/gitlab-runner:latest
