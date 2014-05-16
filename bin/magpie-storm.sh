#!/bin/bash
#############################################################################
#  Copyright (C) 2013 Lawrence Livermore National Security, LLC.
#  Produced at Lawrence Livermore National Laboratory (cf, DISCLAIMER).
#  Written by Albert Chu <chu11@llnl.gov>
#  LLNL-CODE-644248
#  
#  This file is part of Magpie, scripts for running Hadoop on
#  traditional HPC systems.  For details, see <URL>.
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

# This script launches Storm across all nodes for the user

# Make sure the environment variable STORM_CONF_DIR is set.

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

if [ "${STORM_CONF_DIR}X" == "X" ]
then
    echo "User must specify STORM_CONF_DIR"
    exit 1
fi

if [ ! -f ${STORM_CONF_DIR}/workers ]
then
    echo "Cannot find file ${STORM_CONF_DIR}/workers"
    exit 1
fi

if [ ! -f ${STORM_CONF_DIR}/storm-env.sh ]
then
    echo "Cannot find file ${STORM_CONF_DIR}/storm-env.sh"
    exit 1
fi

source ${STORM_CONF_DIR}/storm-env.sh

if [ "${STORM_HOME}X" == "X" ]
then
    echo "STORM_HOME not specified"
    exit 1
fi

if [ "${STORM_LOCAL_DIR}X" == "X" ]
then
    echo "STORM_LOCAL_DIR not specified"
    exit 1
fi

if [ "${MAGPIE_SCRIPTS_HOME}X" == "X" ]
then
    echo "MAGPIE_SCRIPTS_HOME not specified"
    exit 1
fi

if [ ! -f "${MAGPIE_SCRIPTS_HOME}/bin/magpie-launch-storm.sh" ]
then
    echo "Cannot find magpie-launch-storm.sh"
    exit 1
fi

${MAGPIE_SCRIPTS_HOME}/bin/magpie-launch-storm.sh ${STORM_CONF_DIR} ${STORM_LOG_DIR} ${STORM_HOME} ${STORM_LOCAL_DIR} nimbus $1
${MAGPIE_SCRIPTS_HOME}/bin/magpie-launch-storm.sh ${STORM_CONF_DIR} ${STORM_LOG_DIR} ${STORM_HOME} ${STORM_LOCAL_DIR} ui $1

RSH_CMD=${STORM_SSH_CMD:-ssh}

stormnodes=`cat ${STORM_CONF_DIR}/workers`

for stormnode in ${stormnodes}
do
    ${RSH_CMD} ${STORM_SSH_OPTS} ${stormnode} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-launch-storm.sh ${STORM_CONF_DIR} ${STORM_LOG_DIR} ${STORM_HOME} ${STORM_LOCAL_DIR} supervisor $1
    ${RSH_CMD} ${STORM_SSH_OPTS} ${stormnode} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-launch-storm.sh ${STORM_CONF_DIR} ${STORM_LOG_DIR} ${STORM_HOME} ${STORM_LOCAL_DIR} logviewer $1
done
