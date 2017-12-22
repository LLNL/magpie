#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitPhoenixStandardTests_Performanceeval() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
}

SubmitPhoenixStandardTests() {
    for testfunction in __SubmitPhoenixStandardTests_Performanceeval
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

__SubmitPhoenixDependencyTests_Dependency1() {
    local phoenixversion=$1
    local hbaseversion=$2
    local hadoopversion=$3
    local zookeeperversion=$4

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-phoenixperformanceeval

    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
    DependentJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-phoenixperformanceeval
}

__SubmitPhoenixDependencyTests_Dependency2() {
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
    for testfunction in __SubmitPhoenixDependencyTests_Dependency1 __SubmitPhoenixDependencyTests_Dependency2
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
