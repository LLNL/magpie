#!/bin/sh

# This script removes all your files in HDFS.  It's convenient when
# doing testing.

FILES=`${HADOOP_HOME}/bin/hadoop fs -ls 2> /dev/null | grep -v Found | awk '{print $8}'`

if [ "${HADOOP_SETUP_TYPE}" == "MR1" ] || [ "${HADOOP_SETUP_TYPE}" == "HDFS1" ]
then
    rmoption="-rmr"
elif [ "${HADOOP_SETUP_TYPE}" == "MR2" ] || [ "${HADOOP_SETUP_TYPE}" == "HDFS2" ]
then
    rmoption="-rm -r"
fi

for file in $FILES
do
    echo "Removing $file"
    ${HADOOP_HOME}/bin/hadoop fs ${rmoption} $file
done

exit 0
