#!/bin/bash

source test-config.sh

SubmitDefaultStandardTests() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-run-zookeeperruok
    BasicJobSubmit magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
}
