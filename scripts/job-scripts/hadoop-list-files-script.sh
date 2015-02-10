#!/bin/sh

# This script just lists the files in your HDFS home dir.
#
# Convenient for just looking to see what's in there, perhaps after a job

cd ${HADOOP_HOME}

command="bin/hadoop fs -ls"
echo "Running $command" >&2
$command

exit 0