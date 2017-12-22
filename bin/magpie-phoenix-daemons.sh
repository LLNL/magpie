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

# This script launches Phoenix across all nodes for the user

# Make sure the environment variable PHOENIX_CONF_DIR is set.

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

if [ "${PHOENIX_CONF_DIR}X" == "X" ]
then
    echo "User must specify PHOENIX_CONF_DIR"
    exit 1
fi

myhostname=`hostname`
phoenixconfdir=`echo ${PHOENIX_CONF_DIR} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$myhostname/g"`
orig_phoenixconfdir=${PHOENIX_CONF_DIR}

if [ ! -f ${phoenixconfdir}/phoenix-env.sh ]
then
    echo "Cannot find file ${phoenixconfdir}/phoenix-env.sh"
    exit 1
fi

source ${phoenixconfdir}/phoenix-env.sh

if [ ! -f ${phoenixconfdir}/regionservers ]
then
    echo "Cannot find file ${phoenixconfdir}/regionservers"
    exit 1
fi

if [ "${PHOENIX_HOME}X" == "X" ]
then
    echo "PHOENIX_HOME not specified"
    exit 1
fi

if [ "${MAGPIE_SCRIPTS_HOME}X" == "X" ]
then
    echo "MAGPIE_SCRIPTS_HOME not specified"
    exit 1
fi

if [ ! -f "${MAGPIE_SCRIPTS_HOME}/bin/magpie-phoenix-daemon.sh" ]
then
    echo "Cannot find magpie-launch-phoeinx.sh"
    exit 1
fi

RSH_CMD=${PHOENIX_SSH_CMD:-ssh}

for node in `cat ${phoenixconfdir}/regionservers`
do
    phoenixconfdir=`echo ${orig_phoenixconfdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$node/g"`
    hbaseconfdir=`echo ${HBASE_CONF_DIR} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$node/g"`
    ${RSH_CMD} ${PHOENIX_SSH_OPTS} ${node} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-phoenix-daemon.sh ${phoenixconfdir} ${hbaseconfdir} ${PHOENIX_HOME} $1
done
