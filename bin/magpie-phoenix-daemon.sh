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

# This script launches Phoenix for the user

# First argument is path to Phoenix config

# Second argument is path to HBase config

# Third argument is path to Phoenix

# Fourth argument is start or stop

if [ "$1X" == "X" ]
then
    echo "User must specify path to Phoenix config as first argument"
    exit 1
fi

if [ ! -d $1 ]
then
    echo "Phoenix config path is not a directory"
fi

if [ "$2X" == "X" ]
then
    echo "User must specify path to Hbase config as second argument"
    exit 1
fi

if [ ! -d $2 ]
then
    echo "Hbase config path is not a directory"
fi

if [ "$3X" == "X" ]
then
    echo "User must specify path to Phoenix as third argument"
    exit 1
fi

if [ ! -d $3 ]
then
    echo "Phoenix path is not a directory"
fi

if [ "$4X" == "X" ]
then
    echo "User must specify start or stop as fourth argument"
    exit 1
fi

if [ "$4" != "start" ] && [ "$4" != "stop" ]
then
    echo "User must specify start or stop as fourth argument"
    exit 1
fi

source $2/hbase-env.sh
source $1/phoenix-env.sh

myhostname=`hostname`
if [ "$4" == "start" ]
then
    echo "Starting Phoenix on $myhostname"
else
    echo "Stopping Phoenix on $myhostname"
fi
python $3/bin/queryserver.py $4 &

