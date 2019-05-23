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

# This script launches Ray across all nodes for the user

# Make sure the environment variable RAY_CONF_DIR is set.

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

if [ "${RAY_CONF_DIR}X" == "X" ]
then
    echo "User must specify RAY_CONF_DIR"
    exit 1
fi

myhostname=`hostname`
if [ "${MAGPIE_HOSTNAME_CMD_MAP}X" != "X" ]
then
    myhostname=`${MAGPIE_HOSTNAME_CMD_MAP} $myhostname`
    if [ $? -ne 0 ]
    then
        echo "Error in MAGPIE_HOSTNAME_CMD_MAP = ${MAGPIE_HOSTNAME_CMD_MAP}"
        exit 1
    fi
fi

orig_rayconfdir=${RAY_CONF_DIR}
rayconfdir=`echo ${orig_rayconfdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$myhostname/g"`

orig_raylogdir=${RAY_LOG_DIR}
raylogdir=`echo ${orig_raylogdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$myhostname/g"`

if [ ! -f ${rayconfdir}/workers ]
then
    echo "Cannot find file ${rayconfdir}/workers"
    exit 1
fi

if [ "${RAY_PATH}X" == "X" ]
then
    echo "RAY_PATH not specified"
    exit 1
fi

if [ "${RAY_LOG_DIR}X" == "X" ]
then
    echo "RAY_LOG_DIR not specified"
    exit 1
fi

if [ "${MAGPIE_SCRIPTS_HOME}X" == "X" ]
then
    echo "MAGPIE_SCRIPTS_HOME not specified"
    exit 1
fi

if [ ! -f "${MAGPIE_SCRIPTS_HOME}/bin/magpie-ray-daemon.sh" ]
then
    echo "Cannot find magpie-ray-daemon.sh"
    exit 1
fi

if [ "${MAGPIE_RAY_ADDRESS}X" == "X" ]
then
    echo "MAGPIE_RAY_ADDRESS not specified"
    exit 1
fi

${MAGPIE_SCRIPTS_HOME}/bin/magpie-ray-daemon.sh ${RAY_PATH} ${raylogdir} ${MAGPIE_RAY_ADDRESS} master $1

RSH_CMD=${RAY_SSH_CMD:-ssh}

raynodes=`cat ${RAY_CONF_DIR}/workers`

for raynode in ${raynodes}
do
    raylogdir=`echo ${orig_raylogdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$raynode/g"`

    ${RSH_CMD} ${RAY_SSH_OPTS} ${raynode} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-ray-daemon.sh ${RAY_PATH} ${raylogdir} ${MAGPIE_RAY_ADDRESS} worker $1
done
