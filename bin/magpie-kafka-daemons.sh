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

# This script launches Kafka across all nodes for the user

# Make sure the environment variable KAFKA_CONF_DIR is set.

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

if [ "${KAFKA_CONF_DIR}X" == "X" ]
then
    echo "User must specify KAFKA_CONF_DIR"
    exit 1
fi

myhostname=`hostname`
kafkaconfdir=`echo ${KAFKA_CONF_DIR} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$myhostname/g"`
orig_kafkaconfdir=${KAFKA_CONF_DIR}

if [ ! -f ${kafkaconfdir}/kafka-env.sh ]
then
    echo "Cannot find file ${KAFKA_CONF_DIR}/kafka-env.sh"
    exit 1
fi

source ${kafkaconfdir}/kafka-env.sh

if [ ! -f ${kafkaconfdir}/workers ]
then
    echo "Cannot find file ${kafkaconfdir}/workers"
    exit 1
fi

if [ "${KAFKA_HOME}X" == "X" ]
then
    echo "KAFKA_HOME not specified"
    exit 1
fi

if [ "${MAGPIE_SCRIPTS_HOME}X" == "X" ]
then
    echo "MAGPIE_SCRIPTS_HOME not specified"
    exit 1
fi

if [ ! -f "${MAGPIE_SCRIPTS_HOME}/bin/magpie-kafka-daemon.sh" ]
then
    echo "Cannot find magpie-kafka-daemon.sh"
    exit 1
fi

RSH_CMD=${KAFKA_SSH_CMD:-ssh}

# Masters
for node in `cat ${kafkaconfdir}/masters`
do
    kafkaconfdir=`echo ${orig_kafkaconfdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$node/g"`
    ${RSH_CMD} ${KAFKA_SSH_OPTS} ${node} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-kafka-daemon.sh ${kafkaconfdir} ${KAFKA_HOME} $1
done

# Workers
for node in `cat ${kafkaconfdir}/workers`
do
    kafkaconfdir=`echo ${orig_kafkaconfdir} | sed "s/MAGPIEHOSTNAMESUBSTITUTION/$node/g"`
    ${RSH_CMD} ${KAFKA_SSH_OPTS} ${node} ${MAGPIE_SCRIPTS_HOME}/bin/magpie-kafka-daemon.sh ${kafkaconfdir} ${KAFKA_HOME} $1
done
