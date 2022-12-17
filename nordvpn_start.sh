#!/bin/bash

shopt -s nocasematch
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
if [[ ${TECHNOLOGY} != "NordLynx" ]]
then
    20-tun
fi

## Start nordvpn daemon
rm /run/nordvpn/* 2>/dev/null
nordvpnd >/dev/null &
while [ ! -S /run/nordvpn/nordvpnd.sock ]
do
    echo -e $(date "+%F %T%z") "\tINFO\tWaiting for nord daemon to start..."
    sleep 2s
done

## Start nordvpn
echo -e $(date "+%F %T%z") "\tINFO\tConfiguring and connecting NordVPN..."
echo "########################"
nord_config || exit $?
nord_login || exit $?
nord_connect || exit $?
echo "########################"

## Allow NET_LOCAL traffic
30-route
## IPv6 support desired
if [ -n "$netipv6" ]
then
    30-route6 >/dev/null
fi

## Not sure about wanting to include this
## Seems prudent as these are non-VPN connections
## WIP
if [[ -n ${BYPASS_LIST} ]]
then
    if [[ -n ${FIREWALL} && "${FIREWALL}" == "false" || -z ${FIREWALL} ]]
    then
        40-bypasslist
    else
        echo -e $(date "+%F %T%z") "\tWARNING\tFIREWALL use overrides BYPASS_LIST; BYPASS_LIST will not be honored"
        echo -e $(date "+%F %T%z") "\tWARNING\tPlease leave FIREWALL unset or FALSE for BYPASS_LIST to be honored"
    fi
fi

## Expose private key with Wireguard
if [ $(which wg) ]
then
    nord_migrate
fi

## Long run script
echo -e $(date "+%F %T%z") "\tINFO\tStartup complete"
nord_watch &
wait $!
exit $?
