#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh
source test-generate-hadoop-helper.sh
source test-generate-zookeeper-helper.sh

__GenerateHbaseStandardTests_StandardPerformanceEval() {
    local hbaseversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-mr-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="MR"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*-mr-*

    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*sequential-thread*
    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-thread*
    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="sequential-mr"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*sequential-mr*
    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="random-mr"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-mr*

    SetupHDFSoverLustreStandard `ls \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupHDFSoverNetworkFSStandard `ls \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    SetupZookeeperLocal `ls \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*`

    SetupZookeeperNetworkFS `ls \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*`

    SetupZookeeperNotShared `ls \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*`

    SetupZookeeperShared `ls \
        magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*`
}

GenerateHbaseStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hbase Standard Tests"

    for testfunction in __GenerateHbaseStandardTests_StandardPerformanceEval
    do
        for testgroup in ${hbase_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            if ! CheckForDependency "Hbase" "Hadoop" ${!hadoopversion}
            then
                continue
            fi
            if ! CheckForDependency "Hbase" "Zookeeper" ${!zookeeperversion}
            then
                continue
            fi
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

__GenerateHbaseDependencyTests_Dependency1() {
    local hbaseversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hbaseperformanceeval
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hbaseperformanceeval

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*

    SetupZookeeperNetworkFSDependency "Hbase1A" ${hbaseversion} "hdfsoverlustre" `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupZookeeperNetworkFSDependency "Hbase1A" ${hbaseversion} "hdfsovernetworkfs" `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    SetupHDFSoverLustreDependency "Hbase1A" ${hbaseversion} `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupHDFSoverNetworkFSDependency "Hbase1A" ${hbaseversion} `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*`
}

__GenerateHbaseDependencyTests_Dependency2_requiredecommissionhdfs() {
    local hbaseversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4

    # XXX why not start w/ hadoop submission script? Still need zookeeper to take up 3 nodes.

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-scripthbasewritedata
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-scripthbasereaddata
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-hdfs-more-nodes-run-scripthbasereaddata
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-scripthbasewritedata
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-scripthbasereaddata
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-hdfs-more-nodes-run-scripthbasereaddata
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*

    SetupMagpieTestScript "test-hbasewritedata.sh" `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*run-scripthbasewritedata*`

    SetupMagpieTestScript "test-hbasereaddata.sh" `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*run-scripthbasereaddata*`

    SetupZookeeperNetworkFSDependency "Hbase2A" ${hbaseversion} "hdfsoverlustre" `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupZookeeperNetworkFSDependency "Hbase2A" ${hbaseversion} "hdfsovernetworkfs" `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    SetupHDFSoverLustreDependency "Hbase2A" ${hbaseversion} `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupHDFSoverNetworkFSDependency "Hbase2A" ${hbaseversion} `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    SetupHadoopDecommissionHDFSNodes `ls \
        magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*decommissionhdfsnodes*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase2A-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*`
}

GenerateHbaseDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hbase Dependency Tests"

# Dependency 1 Tests, run after another, HDFS over Lustre/NetworkFS
# Dependency 2 Tests, leave data in HDFS, read/write from different jobs, HDFS over Lustre

    for testfunction in __GenerateHbaseDependencyTests_Dependency1 __GenerateHbaseDependencyTests_Dependency2_requiredecommissionhdfs
    do
        for testgroup in ${hbase_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            if ! CheckForDependency "Hbase" "Hadoop" ${!hadoopversion}
            then
                continue
            fi
            if ! CheckForHadoopDecomissionMinimum ${testfunction} "Hbase" "Hadoop" ${!hadoopversion} ${hadoop_decomissionhdfs_minimum}
            then
                continue
            fi
            if ! CheckForDependency "Hbase" "Zookeeper" ${!zookeeperversion}
            then
                continue
            fi
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

GenerateHbasePostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-hbaseperformanceeval*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hbaseperformanceeval-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*-mr-*run-hbaseperformanceeval*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/mr-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-scripthbasewritedata*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scripthbasewritedata-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-scripthbasereaddata*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scripthbasereaddata-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hbase-with-hdfs*hdfs-more-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-more-nodes-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hbase-with-hdfs*"`
    if [ -n "${files}" ]
    then
        # Guarantee 60 minutes for the job that should last awhile
        ${functiontogettimeoutput} 60
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
    fi

    # special node sizes first

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hbase-with-hdfs*hdfs-more-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my_node_count>/${basenodeszookeepernodesmorenodescount}/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hbase-with-hdfs*hdfs-fewer-nodes*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my_node_count>/${basenodeszookeepernodescount}/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hbase-with-hdfs*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my_node_count>/${basenodeszookeepernodescount}/" ${files}
    fi
}
