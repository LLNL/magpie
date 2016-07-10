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

SubmitDefaultRegressionTests_TestAll() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-testall
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-hadoopterasort-run-testpig-regression-testall
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-run-hadoopterasort-run-clustersyntheticcontrol-regression-testall
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-run-zookeeperruok-regression-testall
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-hbaseperformanceeval-run-phoenixperformanceeval-run-zookeeperruok-regression-testall
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-regression-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkpi-regression-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkpi-regression-testall
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-run-zookeeperruok-regression-testall
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
    BasicJobSubmit magpie.${submissiontype}-spark-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-storm-regression-jobtimeout
}

SubmitDefaultRegressionTests_CatchProjectDependencies() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-hbase
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-regression-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-storm-regression-catchprojectdependency-zookeeper
}

SubmitDefaultRegressionTests_NoSetJava() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetjava
    BasicJobSubmit magpie.${submissiontype}-storm-regression-nosetjava
}

SubmitDefaultRegressionTests_BadSetJava() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsetjava
    BasicJobSubmit magpie.${submissiontype}-storm-regression-badsetjava
}

SubmitDefaultRegressionTests_NoSetVersion() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetversion
    BasicJobSubmit magpie.${submissiontype}-storm-regression-nosetversion
}

SubmitDefaultRegressionTests_NoSetHome() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosethome
    BasicJobSubmit magpie.${submissiontype}-storm-regression-nosethome
}

SubmitDefaultRegressionTests_BadSetHome() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsethome
    BasicJobSubmit magpie.${submissiontype}-storm-regression-badsethome
}

SubmitDefaultRegressionTests_NoSetScript() {
    BasicJobSubmit magpie.${submissiontype}-magpie-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-spark-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetscript
    BasicJobSubmit magpie.${submissiontype}-storm-regression-nosetscript
}

SubmitDefaultRegressionTests_BadSetScript() {
    BasicJobSubmit magpie.${submissiontype}-magpie-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-spark-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsetscript
    BasicJobSubmit magpie.${submissiontype}-storm-regression-badsetscript
}

SubmitDefaultRegressionTests_BadJobTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badjobtime
    BasicJobSubmit magpie.${submissiontype}-storm-regression-badjobtime
}

SubmitDefaultRegressionTests_BadStartupTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-storm-regression-badstartuptime
}

SubmitDefaultRegressionTests_BadShutdownTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-storm-regression-badshutdowntime
}

SubmitDefaultRegressionTests() {
    SubmitDefaultRegressionTests_BadJobNames
    SubmitDefaultRegressionTests_TestAll
    SubmitDefaultRegressionTests_InteractiveMode
    SubmitDefaultRegressionTests_JobTimeout
    SubmitDefaultRegressionTests_CatchProjectDependencies

    # Special
    javasave=${JAVA_HOME}
    if [ "${javasave}X" != "X" ]
    then
	unset JAVA_HOME
    fi
    SubmitDefaultRegressionTests_NoSetJava
    if [ "${javasave}X" != "X" ]
    then
	export JAVA_HOME="${javasave}"
    fi

    SubmitDefaultRegressionTests_BadSetJava
    SubmitDefaultRegressionTests_NoSetVersion
    SubmitDefaultRegressionTests_NoSetHome
    SubmitDefaultRegressionTests_BadSetHome
    SubmitDefaultRegressionTests_NoSetScript
    SubmitDefaultRegressionTests_BadSetScript

    SubmitDefaultRegressionTests_BadJobTime
    SubmitDefaultRegressionTests_BadStartupTime
    SubmitDefaultRegressionTests_BadShutdownTime
}
