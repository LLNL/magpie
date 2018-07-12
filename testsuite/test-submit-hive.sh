#!/bin/bash
export HIVE_JOB="interactive"

source test-common.sh
source test-config.sh

__SubmitHiveStandardTests_BasicTests() {
    local hiveversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-hive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hivetestbench
}

SubmitHiveStandardTests() {
    
    for testfunction in __SubmitHiveStandardTests_BasicTests
    do
        for testgroup in ${hive_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Hive" "Hadoop" ${!hadoopversion}
            CheckForDependency "Hive" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done

}

__SubmitHiveDependencyTests_Dependency() {
    local hiveversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hivetestbench
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hivetestbench
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hivetestbench
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hivetestbench

}

SubmitHiveDependencyTests() {
    
    for testfunction in __SubmitHiveDependencyTests_Dependency
    do 
        for testgroup in ${hive_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Hive" "Hadoop" ${!hadoopversion}
            CheckForHadoopDecomissionMinimum ${testfunction} "Hive" "Hadoop" ${!hadoopversion} ${hadoop_decomissionhdfs_minimum}
            CheckForDependency "Hive" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done

}
