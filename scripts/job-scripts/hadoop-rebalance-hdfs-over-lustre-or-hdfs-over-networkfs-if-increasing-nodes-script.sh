#!/bin/bash

# This is a basic script to rebalance HDFS blocks on HDFS over Lustre if you
# have increased the number of nodes you typically run w/ HDFS over Lustre.
#
# The script is simple.  It will copy all files in your home directory
# to a new location, remove the old files, then rename the new
# location back to the original.  Small minor adjustments on the
# user's part may be needed if you need to rebalance files not in your
# home directory, but the script below should work at it's most basic
# core by running it under 'script' mode in the main job submission file and
# setting HADOOP_SCRIPT_PATH to this script.
#
# Those familiar with the start-balancer.sh script should know it
# really can't be used.  HDFS over Lustre does not have real local
# disks, therefore the "local" disk utilization and global "free
# space" numbers don't make much sense in HDFS over Lustre.
 
FILES=`${HADOOP_HOME}/bin/hadoop fs -ls 2> /dev/null | grep -v Found | awk '{print $8}'`

for file in $FILES
do
    echo "Rebalancing $file"
    echo "Copying $file to $file-backup" 
    ${HADOOP_HOME}/bin/hadoop fs -cp $file $file-backup
    echo "Removing $file"
    ${HADOOP_HOME}/bin/hadoop fs -rm -r $file
    echo "Moving $file-backup to $file"
    ${HADOOP_HOME}/bin/hadoop fs -mv $file-backup $file
done

exit 0
