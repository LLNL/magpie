#!/bin/sh

# This script is useful for fixing HDFS corruption

cd ${HADOOP_HOME}

# This will clean up corrupted/missing blocks
command="bin/hdfs fsck -delete"
echo "Running $command" >&2
$command

# You may also just want to just look at fsck output w/
# bin/${fsckscript} fsck <absolute path to file>


exit 0