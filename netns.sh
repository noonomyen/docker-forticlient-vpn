#!/bin/bash

NS_PID=$(sudo docker inspect -f '{{.State.Pid}}' openfortivpn)

if [ -z "$NS_PID" ] || [ "$NS_PID" -eq 0 ]; then
    echo "Error: Invalid or missing PID. Is the container running?"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Usage: $0 <command>"
    exit 1
fi

ORIG_USER=$(logname)

sudo nsenter -t "$NS_PID" -n -- sudo -u "$ORIG_USER" -- "$@"
