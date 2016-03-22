#!/bin/bash

terasortexamples="share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar"

# So output paths aren't the same
uniquestring=`date +"%Y%m%d%N"`

# reduce.tasks = HADOOP_SLAVE_COUNT to make it easy & simple
command="bin/hadoop jar ${terasortexamples} terasort -Dmapred.reduce.tasks=${HADOOP_SLAVE_COUNT} test-teragen test-terasort-${uniquestring}"
echo "Running $command" >&2
$command

exit 0
