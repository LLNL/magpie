#!/bin/bash

# This is a basic script to decomission "nodes" in Hbase w/ HDFS over
# Lustre if you want to start using fewer nodes in your job.  You can
# run it under 'script' mode in the main job submission file and setting
# HBASE_SCRIPT_PATH to this script.
#
# You the user must make only one input into this file, indicate the
# number of nodes you want to decomission at the top of this file in
# the variable "nodecounttodecomission", the input is a positive numer.
#
# You can technically put in any number you want up to the slave
# count, but generally speaking, you shouldn't be too aggressive, as
# other configuration parameters in the Hadoop universe could be
# affected.  For example, if you have HDFS replication of 3 and you
# decomission down to 2 nodes, there'll be issues.
#
# You more than likely will also wish to run the
# hadoop-hdfs-over-lustre-or-hdfs-over-networkfs-nodes-decomission-script.sh
# as well.  As this script will not move all HDFS data, only the data
# related to Hbase.
#
# Some corner case checks will be handled below, but be careful in
# general.

# Edit this number
nodecounttodecomission=0

if [ "${nodecounttodecomission}" == "0" ]
then
    echo "No nodes specified for decomission"
    exit 0
fi

if [ "${nodecounttodecomission}" -ge "${HBASE_REGIONSERVER_COUNT}" ]
then
    echo "Cannot decomission more nodes than are available"
    exit 1
fi

nodesleft=`expr ${HBASE_REGIONSERVER_COUNT} - ${nodecounttodecomission}`

if [ "${HADOOP_HDFS_REPLICATION}X" != "X" ]
then
    if [ "${nodesleft}" -lt "${HADOOP_HDFS_REPLICATION}" ]
    then
	echo "Cannot have fewer nodes than HDFS replication"
	exit 1
    fi
fi

tail -n ${nodecounttodecomission} ${HBASE_CONF_DIR}/regionservers > ${HBASE_CONF_DIR}/regionservers_decomission

cd ${HBASE_HOME}

echo balance_switch false | bin/hbase shell

for server in `cat ${HBASE_CONF_DIR}/regionservers_decomission`
do
    echo "Decomissioning ${server}"
    bin/graceful_stop.sh ${server}
    break
done

exit 0
