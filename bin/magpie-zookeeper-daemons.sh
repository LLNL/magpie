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

# This script launches Zookeeper across all nodes for the user

# Make sure the environment variable ZOOKEEPER_CONF_DIR is set.

# First argument is start or stop

if [ "$1X" == "X" ]
then
    echo "User must start or stop as first argument"
    exit 1
fi

if [ "$1" != "start" ] && [ "$1" != "stop" ]
then
    echo "User must specify start or stop as first argument"
    exit 1
fi

if [ "${ZOOKEEPER_CONF_DIR}X" == "X" ] && [ "${ZOOCFGDIR}X" == "X" ]
then
    echo "User must specify ZOOKEEPER_CONF_DIR or ZOOCFGDIR"
    exit 1
fi

if [ "${ZOOKEEPER_CONF_DIR}X" != "X" ]
then
    zookeeperconfdir=${ZOOKEEPER_CONF_DIR}
else
    zookeeperconfdir=${ZOOCFGDIR}
fi

orig_zookeeperconfdir=${zookeeperconfdir}

myhostname=`hostname`
zookeeperconfdir=`echo ${orig_zookeeperconfdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$myhostname/g"`

if [ ! -f ${zookeeperconfdir}/workers ]
then
    echo "Cannot find file ${zookeeperconfdir}/workers"
    exit 1
fi

if [ ! -f ${zookeeperconfdir}/zookeeper-master-env.sh ]
then
    echo "Cannot find file ${zookeeperconfdir}/zookeeper-master-env.sh"
    exit 1
fi

source ${zookeeperconfdir}/zookeeper-master-env.sh

if [ "${ZOOKEEPER_HOME}X" == "X" ]
then
    echo "ZOOKEEPER_HOME not specified"
    exit 1
fi

if [ "${MAGPIE_SCRIPTS_HOME}X" == "X" ]
then
    echo "MAGPIE_SCRIPTS_HOME not specified"
    exit 1
fi

if [ ! -f "${MAGPIE_SCRIPTS_HOME}/bin/magpie-zookeeper-daemon.sh" ]
then
    echo "Cannot find magpie-zookeeper-daemon.sh"
    exit 1
fi

zookeepernodes=`cat ${zookeeperconfdir}/workers`

RSH_CMD=${ZOOKEEPER_SSH_CMD:-ssh}

for zookeepernode in ${zookeepernodes}
do
    zookeeperconfdir=`echo ${orig_zookeeperconfdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$zookeepernode/g"`
    ${RSH_CMD} ${ZOOKEEPER_SSH_OPTS} ${zookeepernode} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-zookeeper-daemon.sh ${zookeeperconfdir} ${ZOOKEEPER_HOME} $1
done
