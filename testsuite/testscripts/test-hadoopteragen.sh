#!/bin/bash

terasortexamples="share/hadoop/mapreduce/hadoop-mapreduce-examples-$HADOOP_VERSION.jar"

# Small but enough for a block size
terasortsize=10000000

cd ${HADOOP_HOME}
            
# map tasks = HADOOP_SLAVE_COUNT to make it easy & simple
if [ "${HADOOP_SETUP_TYPE}" == "MR1" ]
then
    mapreducemaptasks="-Dmapred.map.tasks=${HADOOP_SLAVE_COUNT}"
elif [ "${HADOOP_SETUP_TYPE}" == "MR2" ]
then
    mapreducemaptasks="-Dmapreduce.job.maps=${HADOOP_SLAVE_COUNT}"
fi

command="bin/hadoop jar ${terasortexamples} teragen ${mapreducemaptasks} $terasortsize test-teragen"
echo "Running $command" >&2
$command

exit 0
