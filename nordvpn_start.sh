#!/bin/bash

## Set iptables
## NET_LOCAL is blocked until VPN connected
00-firewall
10-inet
## IPv6 support desired
netipv6=$(dockerNetworks6)
if [ -n "$netipv6" ]
then
    10-inet6
fi

## if not using Nordlynx
shopt -s nocasematch
if [[ ${TECHNOLOGY} != "NordLynx" ]]
then
    20-tun
fi

## Not sure about wanting to include this
## Seems prudent as these are non-VPN connections
## TBD
# 40-allowlist >/dev/null

## Start nordvpn daemon
rm /run/nordvpn/* 2>/dev/null
nordvpnd >/dev/null &
while [ ! -S /run/nordvpn/nordvpnd.sock ]
do
    echo "Waiting for nord daemon to start..."
    sleep 2s
done

## Start nordvpn
nord_config || exit $?
nord_login || exit $?
nord_connect || exit $?

## Allow NET_LOCAL traffic
30-route
## IPv6 support desired
if [ -n "$netipv6" ]
then
    30-route6 >/dev/null
fi

## Expose private key with Wireguard
if [ $(which wg) ]
then
    nord_migrate
fi

## Long run script
echo "Startup complete |" $(date "+%F %T %z")
nord_watch &
wait $!
exit $?
