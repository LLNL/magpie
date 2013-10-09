#!/bin/sh

# This script executes some teragens.  It is convenient for putting
# data into your file system for some tests.

cd ${HADOOP_HOME}

if [ "${HADOOP_SETUP_TYPE}" == "MR1" ]
then
    terasortexamples="hadoop-examples-$HADOOP_VERSION.jar"
    rmoption="-rmr"
elif [ "${HADOOP_SETUP_TYPE}" == "MR2" ]
then
    terasortexamples="share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar"
    rmoption="-rm -r"
fi

command="bin/hadoop jar ${terasortexamples} teragen 50000000 teragen-1"
echo "Running $command" >&2
$command

command="bin/hadoop jar ${terasortexamples} teragen 50000000 teragen-2"
echo "Running $command" >&2
$command
   
command="bin/hadoop fs -ls"
echo "Running $command" >&2
$command

exit 0