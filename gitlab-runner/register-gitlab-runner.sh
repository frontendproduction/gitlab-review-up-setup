#!/bin/bash
export GITLAB_URL=https://git.izex.org/
export GITLAB_TOKEN=5Nz-y8eVHUkvyT6KrkYU

gitlab-runner \
    register -n \
    --name "FP Review App Runner" \
    --executor shell \
    --docker-image docker:latest \
    --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
    --url $GITLAB_URL \
    --registration-token $GITLAB_TOKEN \
    --tag-list review-app-swarm
