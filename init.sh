#!/usr/bin/env sh

# Install ACL and set allow "gitlab-runner" user (which typical id is 999, and he exsits only inside jobs and thre is
# no such user in the system) to user docker.sock
sudo apt intall acl
sudo setfacl --modify user:999:rw /var/run/docker.sock

# Rise number of allowed file system watchers to sky high, cause node and webpack can overcome the number
# that is set by default
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
