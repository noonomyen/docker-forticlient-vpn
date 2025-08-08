#!/bin/sh

set -e

cleanup() {
    echo "Caught signal, terminating child processes..."
    kill -TERM "$vpn_pid" "$sockd_pid" 2>/dev/null
    wait "$vpn_pid"
    wait "$sockd_pid"
    exit 0
}

trap cleanup INT TERM

echo "Starting openfortivpn..."
openfortivpn -c "/etc/openfortivpn/config" &
vpn_pid=$!

while true; do
    if ip link show ppp0 2>/dev/null | grep -q "<.*UP.*>"; then
        if ip route | grep -q "ppp0"; then
            break
        fi
    fi
    echo "Waiting for ppp0 interface to be UP and have route..."
    sleep 1
done

echo "ppp0 is up and ready, starting sockd..."

sockd -f /etc/sockd.conf -D &
sockd_pid=$!

wait "$vpn_pid"
wait "$sockd_pid"
