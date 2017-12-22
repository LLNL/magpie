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

# This script launches Storm for the user

# First argument is path to Storm config dir

# Second argument is path to Storm log dir

# Second argument is path to Storm

# Third argument is path to Storm scratch dir

# Fourth argument is 'nimbus', 'supervisor', 'ui', or 'logviewer'

# Fifth argument is start or stop

if [ "$1X" == "X" ]
then
    echo "User must specify path to Storm config as first argument"
    exit 1
fi

if [ ! -d $1 ]
then
    echo "Storm config path is not a directory"
fi

if [ "$2X" == "X" ]
then
    echo "User must specify path to Storm log as second argument"
    exit 1
fi

if [ ! -d $2 ]
then
    echo "Storm log path is not a directory"
fi

if [ "$3X" == "X" ]
then
    echo "User must specify path to Storm as third argument"
    exit 1
fi

if [ ! -d $3 ]
then
    echo "Storm path is not a directory"
fi

if [ "$4X" == "X" ]
then
    echo "User must specify path to Storm scratch dir as fourth argument"
    exit 1
fi

if [ ! -d $4 ]
then
    echo "Storm scratch dir is not a directory"
fi

if [ "$5X" == "X" ]
then
    echo "User must specify nimbus, supervisor, ui, or logviewer as fifth argument"
    exit 1
fi

if [ "$5" != "nimbus" ] && [ "$5" != "supervisor" ] && [ "$5" != "ui" ] && [ "$5" != "logviewer" ]
then
    echo "User must specify nimbus, supervisor, ui, or logviewer as fifth argument"
    exit 1
fi

if [ "$6X" == "X" ]
then
    echo "User must specify start or stop as sixth argument"
    exit 1
fi

if [ "$6" != "start" ] && [ "$6" != "stop" ]
then
    echo "User must specify start or stop as sixth argument"
    exit 1
fi

source $1/storm-daemon-env.sh

myhostname=`hostname`
if [ "$6" == "start" ]
then
    if [ -f "$4/storm-$5.pid" ]
    then
        echo "Storm $5 pid file found, it should already be running"
    else
        echo "Starting Storm $5 on $myhostname - output stored in $2/storm-$5.out"
        nohup $3/bin/storm $5 > $2/storm-$5.out 2>&1 < /dev/null &
        scriptpid=$!
        echo $scriptpid > $4/storm-$5.pid
    fi
else
    if [ -f "$4/storm-$5.pid" ]
    then
        scriptpid=`cat $4/storm-$5.pid`
        echo "Killing Storm $5 on $myhostname"
        kill -9 $scriptpid
        rm -f $4/storm-$5.pid
    else
        echo "Cannot find pid file $4/storm-$5.pid"
    fi
fi

