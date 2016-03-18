#!/bin/bash

# This is a basic script to decommission "nodes" in HDFS over Lustre if
# you want to start using fewer nodes in your job.  You can run it
# under 'script' mode in the main job submission file and setting
# HADOOP_SCRIPT_PATH to this script.
#
# You the user must make only one input into this file, indicate the
# number of nodes you want to decommission at the top of this file in
# the variable "nodecounttodecommission", the input is a positive numer.
#
# You can technically put in any number you want up to the slave
# count, but generally speaking, you shouldn't be too aggressive, as
# other configuration parameters in the Hadoop universe could be
# affected.  For example, if you have HDFS replication of 3 and you
# decommission down to 2 nodes, there'll be issues.
#
# Some corner case checks will be handled below, but be careful in
# general.

# Edit this number
nodecounttodecommission=0

if [ "${nodecounttodecommission}" == "0" ]
then
    echo "No nodes specified for decommission"
    exit 0
fi

if [ "${nodecounttodecommission}" -ge "${HADOOP_SLAVE_COUNT}" ]
then
    echo "Cannot decommission more nodes than are available"
    exit 1
fi

nodesleft=`expr ${HADOOP_SLAVE_COUNT} - ${nodecounttodecommission}`

if [ "${HADOOP_HDFS_REPLICATION}X" != "X" ]
then
    if [ "${nodesleft}" -lt "${HADOOP_HDFS_REPLICATION}" ]
    then
	echo "Cannot have fewer nodes than HDFS replication"
	exit 1
    fi
fi

echo "Creating ${HADOOP_CONF_DIR}/hosts-exclude"
tail -n ${nodecounttodecommission} ${HADOOP_CONF_DIR}/hosts-include > ${HADOOP_CONF_DIR}/hosts-exclude

cd ${HADOOP_HOME}

echo "Refreshing nodes in namenode"
bin/hadoop dfsadmin -refreshNodes

while true 
do
    count=`bin/hadoop dfsadmin -report | grep 'Decommission Status : Decommissioned' | wc -l`
    if [ ${count} -lt "${nodecounttodecommission}" ]
    then
	echo "Done decommissioning ${count} nodes out of ${nodecounttodecommission} ... sleeping for a bit "
        sleep 30
        continue
    fi

    echo "Decommissioned ${count} nodes"
    break
done

if [ "${HADOOP_FILESYSTEM_MODE}" == "hdfsoverlustre" ]
then
    count=0
    while [ "${count}" -lt "${nodecounttodecommission}" ]
    do
	noderank=`expr ${HADOOP_SLAVE_COUNT} - ${count}`
        if [ "${HADOOP_PER_JOB_HDFS_PATH}" == "yes" ]
        then
  	    rmpath="${HADOOP_HDFSOVERLUSTRE_PATH}/${MAGPIE_JOB_ID}/node-$noderank"
        else
  	    rmpath="${HADOOP_HDFSOVERLUSTRE_PATH}/node-$noderank"
        fi    
	echo "Removing path ${rmpath} ..."
	rm -rf ${rmpath}
	count=`expr $count + 1`
    done
fi

if [ "${HADOOP_FILESYSTEM_MODE}" == "hdfsovernetworkfs" ]
then
    count=0
    while [ "${count}" -lt "${nodecounttodecommission}" ]
    do
	noderank=`expr ${HADOOP_SLAVE_COUNT} - ${count}`
        if [ "${HADOOP_PER_JOB_HDFS_PATH}" == "yes" ]
        then
	    rmpath="${HADOOP_HDFSOVERNETWORKFS_PATH}/${MAGPIE_JOB_ID}/node-$noderank"
        else
	    rmpath="${HADOOP_HDFSOVERNETWORKFS_PATH}/node-$noderank"
        fi
	echo "Removing path ${rmpath} ..."
	rm -rf ${rmpath}
	count=`expr $count + 1`
    done
fi

exit 0
