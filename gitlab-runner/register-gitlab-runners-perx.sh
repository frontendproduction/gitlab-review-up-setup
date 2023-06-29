#!/usr/bin/env sh
export GITLAB_URL=https://gitlab.com/
export GITLAB_TOKEN=GR1348941nnbM7VtMPTHr_or5VYRs

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
