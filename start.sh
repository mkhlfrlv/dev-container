#!/bin/bash
printenv | grep ^KUBERNETES_ > /etc/k8s-env
exec /usr/sbin/sshd -D