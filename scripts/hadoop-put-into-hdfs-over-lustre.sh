#!/bin/bash

# This is a basic script to move from Lustre into HDFS over Lustre.
 
cd ${HADOOP_HOME}

# hadoop fs -copyFromLocal <lustre-dir> <hdfs-dir>
command="hadoop fs -copyFromLocal FOO BAR"
echo "Running $command" >&2
$command

exit 0
