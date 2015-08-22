#!/bin/sh

cd $HADOOP_HOME
bin/hadoop fs -mkdir -p hdfs:///user/achu
bin/hadoop fs -copyFromLocal /home/achu/hadoop/magpie/submission-scripts/tests/mypigdata hdfs:///user/achu/mypigdata

cd $PIG_HOME
bin/pig -stop_on_failure -l /home/achu/hadoop/magpie/submission-scripts/tests/mytestpig.log /home/achu/hadoop/magpie/submission-scripts/tests/mytest.pig
