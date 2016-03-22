#!/bin/bash

terasortexamples="share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar"

# Small but enough for a block size
terasortsize=10000000

cd ${HADOOP_HOME}
	    
# map.tasks = HADOOP_SLAVE_COUNT to make it easy & simple
command="bin/hadoop jar ${terasortexamples} teragen -Dmapred.map.tasks=${HADOOP_SLAVE_COUNT} $terasortsize test-teragen"
echo "Running $command" >&2
$command

exit 0
