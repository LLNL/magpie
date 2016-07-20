#!/bin/sh

# This script removes all your files in HDFS.  It's convenient when
# doing testing.

FILES=`${HADOOP_HOME}/bin/hadoop fs -ls 2> /dev/null | grep -v Found | awk '{print $8}'`

for file in $FILES
do
    echo "Removing $file"
    ${HADOOP_HOME}/bin/hadoop fs -rm -r $file
done

exit 0
