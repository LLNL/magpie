#!/bin/bash

source test-config.sh

SubmitDefaultStandardTests() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-default-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-default-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-default-run-testpig
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-default-run-testpig-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-default-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-default-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-default-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-default-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-hive-default-run-testbench
    BasicJobSubmit magpie.${submissiontype}-spark-default-run-sparkpi
    BasicJobSubmit magpie.${submissiontype}-spark-default-run-sparkpi-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-default-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-default-run-sparkwordcount-copy-in-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-default-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-default-run-sparkwordcount-copy-in-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-default-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-default-run-sparkwordcount-copy-in-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-storm-default-run-stormwordcount
    BasicJobSubmit magpie.${submissiontype}-storm-default-run-stormwordcount-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-default-run-zookeeperruok
    BasicJobSubmit magpie.${submissiontype}-zookeeper-default-run-zookeeperruok-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-default-run-checkzeppelinup
}
