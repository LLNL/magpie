#!/bin/sh

SubmitDefaultStandardTests() {
    if [ "${hadooptests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort
	BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-no-local-dir
    fi
    if [ "${pigtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-no-local-dir
    fi
    if [ "${mahouttests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-no-local-dir
    fi
    if [ "${hbasetests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-no-local-dir
    fi
    if [ "${phoenixtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-no-local-dir
    fi
    if [ "${sparktests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi
	BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-no-local-dir
    fi
    if [ "${stormtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount
	BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-no-local-dir
    fi
    if [ "${zookeepertests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-zookeeper-run-zookeeperruok
	BasicJobSubmit magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
    fi
}

SubmitDefaultRegressionTests() {
    if [ "${hadooptests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-job-name-dollarsign
    fi
    if [ "${pigtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-job-name-dollarsign
    fi
    if [ "${mahouttests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-job-name-dollarsign
    fi
    if [ "${hbasetests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-job-name-dollarsign
    fi
    if [ "${phoenixtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-job-name-dollarsign
    fi
    if [ "${sparktests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-regression-job-name-dollarsign
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name-dollarsign
    fi
    if [ "${stormtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-regression-job-name-whitespace
	BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-regression-job-name-dollarsign
    fi
}
