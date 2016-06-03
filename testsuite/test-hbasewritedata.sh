#!/bin/bash

cd ${HBASE_HOME}

command="bin/hbase org.apache.hadoop.hbase.PerformanceEvaluation --nomapred --rows=1048576 sequentialWrite 4"
echo "Running $command" >&2
$command

exit 0
