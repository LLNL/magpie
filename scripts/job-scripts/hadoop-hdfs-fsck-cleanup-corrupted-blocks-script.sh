#!/bin/sh

# This script just lists the files in your HDFS home dir.
#
# Convenient for just looking to see what's in there, perhaps after a job

cd ${HADOOP_HOME}

if [ "${HADOOP_SETUP_TYPE}" == "MR1" ] || [ "${HADOOP_SETUP_TYPE}" == "HDFS1" ]
then
    fsckscript="hadoop"
elif [ "${HADOOP_SETUP_TYPE}" == "MR2" ] || [ "${HADOOP_SETUP_TYPE}" == "HDFS2" ]
then
    fsckscript="hdfs"
fi

# This will clean up corrupted/missing blocks
command="bin/${fsckscript} fsck -delete"
echo "Running $command" >&2
$command

# You may also just want to just look at fsck output w/
# bin/${fsckscript} fsck <absolute path to file>


exit 0