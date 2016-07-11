#!/bin/bash

source test-common.sh
source test-config.sh

SubmitPhoenixStandardTests_Performanceeval() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4

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
    for testfunction in SubmitPhoenixStandardTests_Performanceeval
    do
        for testgroup in ${phoenix_test_groups}
        do
            local hbaseversion="${testgroup}_hbaseversion"
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hbaseversion} ${!hadoopversion} ${!zookeeperversion}
            done
        done
    done
}

SubmitPhoenixDependencyTests_Dependency1() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
}

SubmitPhoenixDependencyTests_Dependency2() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4

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
    for testfunction in SubmitPhoenixDependencyTests_Dependency1 SubmitPhoenixDependencyTests_Dependency2
    do
        for testgroup in ${phoenix_test_groups}
        do
            local hbaseversion="${testgroup}_hbaseversion"
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hbaseversion} ${!hadoopversion} ${!zookeeperversion}
            done
        done
    done
}
