#!/bin/bash

source test-common.sh

SubmitPhoenixStandardTests_Performanceeval() {
    phoenixversion=$1
    hbaseversion=$2
    hadoopversion=$3
    zookeeperversion=$4

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval
    
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
}

SubmitPhoenixStandardTests() {
    for phoenixversion in ${phoenixhbase11hadoop27zookeeper348java17versions}
    do
	for hbaseversion in 1.1.0
	do
	    for hadoopversion in 2.7.0
	    do
		for zookeeperversion in 3.4.8
		do
		    SubmitPhoenixStandardTests_Performanceeval ${phoenixversion} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done
    done
}

SubmitPhoenixDependencyTests_Dependency1() {
    phoenixversion=$1
    hbaseversion=$2
    hadoopversion=$3
    zookeeperversion=$4

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
}

SubmitPhoenixDependencyTests_Dependency2() {
    phoenixversion=$1
    hbaseversion=$2
    hadoopversion=$3
    zookeeperversion=$4

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hbaseperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hbaseperformanceeval
    
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hbaseperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hbaseperformanceeval
}

SubmitPhoenixDependencyTests() {
    for phoenixversion in ${phoenixhbase11hadoop27zookeeper348java17versions}
    do
	for hbaseversion in 1.1.0
	do
	    for hadoopversion in 2.7.0
	    do
		for zookeeperversion in 3.4.8
		do
		    SubmitPhoenixDependencyTests_Dependency1 ${phoenixversion} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done
    done

    for phoenixversion in ${phoenixhbase11hadoop27zookeeper348java17versions}
    do
	for hbaseversion in 1.1.0
	do
	    for hadoopversion in 2.7.0
	    do
		for zookeeperversion in 3.4.8
		do
		    SubmitPhoenixDependencyTests_Dependency2 ${phoenixversion} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done
    done
}
