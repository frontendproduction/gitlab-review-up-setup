#!/usr/bin/env sh
export GITLAB_URL=https://git.izex.org/
export GITLAB_TOKEN=5Nz-y8eVHUkvyT6KrkYU

gitlab-runner \
    register -n \
    --name "FP Swarm Shell" \
    --executor shell \
    --docker-image docker:latest \
    --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
    --url $GITLAB_URL \
    --registration-token $GITLAB_TOKEN \
    --tag-list review-app-swarm

gitlab-runner \
    register -n \
    --name "FP Swarm Docker" \
    --executor docker \
    --docker-image docker:latest \
    --docker-volumes /var/run/docker.sock:/var/run/docker.sock \
    --url $GITLAB_URL \
    --registration-token $GITLAB_TOKEN \
    --tag-list docker
