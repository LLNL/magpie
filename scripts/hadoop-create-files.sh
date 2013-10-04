#!/bin/sh

# This script executes some teragens with Hadoop 2.0.  It is
# convenient for putting data into your file system for some tests.

cd ${HADOOP_BUILD_HOME}

command="bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar teragen 50000000 teragen-1"
echo "Running $command" >&2
$command

command="bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar teragen 50000000 teragen-2"
echo "Running $command" >&2
$command
   
command="bin/hadoop fs -ls"
echo "Running $command" >&2
$command

exit 0