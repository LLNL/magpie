#!/bin/bash

# This is a basic script to move from Lustre into HDFS over Lustre.

cd ${HADOOP_HOME}

# bin/hadoop fs -mkdir -p <hdfs-dir>
# bin/hadoop fs -copyFromLocal <lustre-dir> <hdfs-dir>

command="bin/hadoop fs -mkdir -p BAR"
echo "Running $command" >&2
$command

command="bin/hadoop fs -copyFromLocal FOO BAR"
echo "Running $command" >&2
$command

exit 0
