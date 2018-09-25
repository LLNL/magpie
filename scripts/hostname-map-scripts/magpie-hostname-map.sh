#!/bin/bash

# This script takes the first argument and converts it from nodeX to
# node-ibX, where X is assumed to be trailing numbers.
#
# This could be set in MAGPIE_HOSTNAME_CMD_MAP or
# MAGPIE_HOSTNAME_SCHEDULER_MAP.

if [ -n "$1" ]
then
    host=$1
    prefix=`echo $host | sed 's/[0-9]//g'`
    suffix=`echo $host | sed 's/[^0-9]//g'`
    echo ${prefix}-ib${suffix}
    exit 0
fi

exit 1
