#!/bin/bash

cd $HADOOP_HOME
bin/hadoop fs -mkdir -p hdfs:///user/achu
bin/hadoop fs -copyFromLocal ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pigdata hdfs:///user/achu/test-pigdata

cd $PIG_HOME
bin/pig -stop_on_failure -l ${MAGPIE_SCRIPTS_HOME}/testsuite/mytestpig.log ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pig.pig
