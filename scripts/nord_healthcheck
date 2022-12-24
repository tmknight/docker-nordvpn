#!/bin/bash
STAT=$(nordvpn status | grep -Eio --color=never "Status: Connected")
CHK=$(curl -Is -m 5 -o /dev/null -w "%{http_code}" "${CHECK_CONNECTION_URL:-https://www.google.com}")
CODE=0
if [ -z "$STAT" ]
then
    STAT="Status: Disconnected"
    CODE=1
elif [[ ! $CHK =~ ^[23] ]]
then
    STAT="Status: Unstable"
    CODE=2
fi
echo -n $STAT
exit $CODE
