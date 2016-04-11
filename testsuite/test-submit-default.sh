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

SubmitDefaultDependencyTests() {

    if [ "${hadooptests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.2.0-run-hadoopterasort
	if [ "${pigtests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.2.0-pig-0.12.0-run-testpig
	fi
	if [ "${hbasetests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval
	fi
	if [ "${sparktests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-spark-0.9.1-bin-hadoop2-run-sparkwordcount-copy-in
	fi
    fi

    if [ "${hadooptests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.4.0-run-hadoopterasort
	if [ "${pigtests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.4.0-pig-0.12.0-run-testpig
	fi
	if [ "${hbasetests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval
	fi
	if [ "${sparktests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount-copy-in
	fi
    fi

    if [ "${hadooptests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.6.0-run-hadoopterasort
	if [ "${pigtests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.6.0-pig-0.14.0-run-testpig
	fi
	if [ "${hbasetests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval
	fi
	if [ "${sparktests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount-copy-in
	fi
    fi

    if [ "${hadooptests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyGlobalOrder1D-hadoop-2.7.0-run-hadoopterasort
	if [ "${pigtests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1D-hadoop-2.7.0-pig-0.15.0-run-testpig
	fi
	if [ "${mahouttests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyGlobalOrder1D-hadoop-2.7.0-mahout-0.11.1-run-clustersyntheticcontrol
	fi
	if [ "${hbasetests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-hbase-1.1.3-zookeeper-3.4.8-run-hbaseperformanceeval
	fi
	if [ "${sparktests}" == "y" ]
	then
	    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-spark-1.5.0-bin-hadoop2.6-run-sparkwordcount-copy-in
	fi
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
