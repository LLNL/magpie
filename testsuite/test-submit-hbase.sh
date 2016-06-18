#!/bin/bash

source test-common.sh

SubmitHbaseStandardTests_StandardPerformanceEval() {
    hbaseversion=$1
    hadoopversion=$2
    zookeeperversion=$3

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
}

SubmitHbaseStandardTests() {
    for testfunction in SubmitHbaseStandardTests_StandardPerformanceEval
    do
	for hbaseversion in ${hbasehadoop26zookeeper34java16versions}
	do
	    for hadoopversion in ${hbasehadoop26zookeeper34java16versions_hadoopversion}
	    do
		for zookeeperversion in ${hbasehadoop26zookeeper34java16versions_zookeeperversion}
		do
		    ${testfunction} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done
    
	for hbaseversion in ${hbasehadoop27zookeeper34java17versions}
	do
	    for hadoopversion in ${hbasehadoop27zookeeper34java17versions_hadoopversion}
	    do
		for zookeeperversion in ${hbasehadoop27zookeeper34java17versions_zookeeperversion}
		do
		    ${testfunction} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done
    done
}

SubmitHbaseDependencyTests_Dependency1() {
    hbaseversion=$1
    hadoopversion=$2
    zookeeperversion=$3

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hbaseperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hbaseperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hbaseperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hbaseperformanceeval
}

SubmitHbaseDependencyTests_Dependency2() {
    hbaseversion=$1
    hadoopversion=$2
    zookeeperversion=$3

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-scripthbasewritedata
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-scripthbasereaddata
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-hdfs-more-nodes-run-scripthbasereaddata
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-scripthbasereaddata

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-scripthbasewritedata
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-scripthbasereaddata
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-hdfs-more-nodes-run-scripthbasereaddata
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-scripthbasereaddata
}

SubmitHbaseDependencyTests() {
    
    for testfunction in SubmitHbaseDependencyTests_Dependency1 SubmitHbaseDependencyTests_Dependency2
    do
	for hbaseversion in ${hbasehadoop26zookeeper34java16versions}
	do
	    for hadoopversion in ${hbasehadoop26zookeeper34java16versions_hadoopversion}
	    do
		for zookeeperversion in ${hbasehadoop26zookeeper34java16versions_zookeeperversion}
		do
		    ${testfunction} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done

	for hbaseversion in ${hbasehadoop27zookeeper34java17versions}
	do
	    for hadoopversion in ${hbasehadoop27zookeeper34java17versions_hadoopversion}
	    do
		for zookeeperversion in ${hbasehadoop27zookeeper34java17versions_zookeeperversion}
		do
		    ${testfunction} ${hbaseversion} ${hadoopversion} ${zookeeperversion}
		done
	    done
	done
    done
}