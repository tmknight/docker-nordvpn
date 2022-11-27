#!/bin/bash
STAT=$(nordvpn status | grep -Eio --color=never "Status: Connected")
CODE=0
if [ -z "$STAT" ]
then
    STAT="Status: Disconnected"
    CODE=1
fi
echo -n $STAT
exit $CODE
