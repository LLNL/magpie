#!/bin/bash
#############################################################################
#  Copyright (C) 2013-2015 Lawrence Livermore National Security, LLC.
#  Produced at Lawrence Livermore National Laboratory (cf, DISCLAIMER).
#  Written by Albert Chu <chu11@llnl.gov>
#  LLNL-CODE-644248
#
#  This file is part of Magpie, scripts for running Hadoop on
#  traditional HPC systems.  For details, see https://github.com/llnl/magpie.
#
#  Magpie is free software; you can redistribute it and/or modify it
#  under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  Magpie is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with Magpie.  If not, see <http://www.gnu.org/licenses/>.
#############################################################################

# This script launches Ray for the user

# First argument is path to Ray

# Second argument is path to Ray log dir

# Third argument is ray address in ip:port format

# Fourth argument is 'master' or 'worker'

# Fifth argument is start or stop

if [ "$1X" == "X" ]
then
    echo "User must specify path to Ray as first argument"
    exit 1
fi

if [ ! -x $1 ]
then
    echo "Ray path is not executable"
fi

if [ "$2X" == "X" ]
then
    echo "User must specify path to Ray log as second argument"
    exit 1
fi

if [ ! -d $2 ]
then
    echo "Ray log path is not a directory"
fi

if [ "$3X" == "X" ]
then
    echo "User must specify ray address as third argument"
    exit 1
fi

if ! echo $3 | grep -q ":"
then
    echo "Ray address must be in ip:port format"
    exit 1
fi

raynode=`echo $3 | cut -d: -f1`
rayip=`getent hosts ${raynode} | awk '{print $1}'`
rayport=`echo $3 | cut -d: -f2`

if [ "$4X" == "X" ]
then
    echo "User must specify master or worker as fourth argument"
    exit 1
fi

if [ "$4" != "master" ] && [ "$4" != "worker" ]
then
    echo "User must specify master or worker as fourth argument"
    exit 1
fi

if [ "$5X" == "X" ]
then
    echo "User must specify start or stop as fifth argument"
    exit 1
fi

if [ "$5" != "start" ] && [ "$5" != "stop" ]
then
    echo "User must specify start or stop as fifth argument"
    exit 1
fi

myhostname=`hostname`
if [ "$5" == "start" ]
then
    echo "Starting Ray $5 on $myhostname - output stored in $2/ray-$4.out"
    if [ "$4" == "master" ]
    then
        nohup $1 start --head --node-ip-address=${rayip} --redis-port=${rayport} > $2/ray-$4.out 2>&1 < /dev/null &
    else
        nohup $1 start --redis-address=$3 > $2/ray-$4.out 2>&1 < /dev/null &
    fi
else
    echo "Stopping Ray on $myhostname"
    $1 stop
fi
