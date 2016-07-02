#!/bin/bash

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

SubmitDefaultRegressionTests_BadJobNames () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-regression-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-regression-job-name-dollarsign
}

SubmitDefaultRegressionTests_InteractiveMode () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-storm-regression-interactive-mode
}

SubmitDefaultRegressionTests_JobTimeout () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-storm-regression-jobtimeout
}

SubmitDefaultRegressionTests() {
    SubmitDefaultRegressionTests_BadJobNames
    SubmitDefaultRegressionTests_InteractiveMode
    SubmitDefaultRegressionTests_JobTimeout
}
