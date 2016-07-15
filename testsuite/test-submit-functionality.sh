#!/bin/bash

source test-config.sh

__SubmitFunctionalityTests_BadJobNames () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-job-name-dollarsign
}

__SubmitFunctionalityTests_AltConfFilesDir () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altconffilesdir
}

__SubmitFunctionalityTests_TestAll() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-hadoopterasort-run-testpig-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-hadoopterasort-run-clustersyntheticcontrol-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-run-zookeeperruok-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-hbaseperformanceeval-run-phoenixperformanceeval-run-zookeeperruok-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkpi-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-hadoopterasort-run-sparkpi-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-run-zookeeperruok-functionality-testall
}

__SubmitFunctionalityTests_InteractiveMode () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-interactive-mode
}

__SubmitFunctionalityTests_JobTimeout () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-jobtimeout
}

__SubmitFunctionalityTests_MagpieExports() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hadoop-rawnetworkfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-rawnetworkfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-zookeeper-functionality-checkexports
}

SubmitFunctionalityTests() {
    __SubmitFunctionalityTests_BadJobNames
    __SubmitFunctionalityTests_AltConfFilesDir
    __SubmitFunctionalityTests_TestAll
    __SubmitFunctionalityTests_InteractiveMode
    __SubmitFunctionalityTests_JobTimeout
    __SubmitFunctionalityTests_MagpieExports
}
