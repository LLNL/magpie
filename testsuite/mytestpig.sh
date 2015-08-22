#!/bin/sh

cd $HADOOP_HOME
bin/hadoop fs -mkdir -p hdfs:///user/achu
bin/hadoop fs -copyFromLocal ${MAGPIE_SCRIPTS_HOME}/submission-scripts/tests/mypigdata hdfs:///user/achu/mypigdata

cd $PIG_HOME
bin/pig -stop_on_failure -l ${MAGPIE_SCRIPTS_HOME}/submission-scripts/tests/mytestpig.log ${MAGPIE_SCRIPTS_HOME}/submission-scripts/tests/mytest.pig
