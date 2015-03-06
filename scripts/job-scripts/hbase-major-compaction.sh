#!/bin/sh

# This script performs a major compaction on all Hbase tables.

cd ${HBASE_HOME}

command="echo list"
echo "Running $command in hbase shell" >&2
listoutput=`$command | bin/hbase shell | sed -n '/TABLE/,/seconds/p' | tail -n+2 | head -n -1`

for table in ${listoutput}
do
    command="echo major_compact '${table}'"
    echo "Running $command in hbase shell" >&2
    $command | bin/hbase shell
done

exit 0