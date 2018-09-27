#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh
source test-generate-hadoop-helper.sh
source test-generate-zookeeper-helper.sh

__GenerateHiveStandardTests_StandardPerformanceEval() {
    local hiveversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-zookeeper-not-shared-zookeeper-networkfs-run-hivetestbench

sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HIVE_VERSION="\(.*\)"/export HIVE_VERSION="'"${hiveversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-hive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*

    SetupHDFSoverLustreStandard `ls \
        magpie.${submissiontype}-hadoop-and-hive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`
}

GenerateHiveStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hive Standard Tests"

    for testfunction in __GenerateHiveStandardTests_StandardPerformanceEval
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

__GenerateHiveDependencyTests_Dependency() {
    local hiveversion=$1
    local hadoopversion=$2
    local zookeeperversion=$3
    local javaversion=$4
# HDFS over Lustre
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-run-hivetestbench
# HDFS over networkFS
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-run-hivetestbench

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export HIVE_VERSION="\(.*\)"/export HIVE_VERSION="'"${hiveversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*

    SetupZookeeperNetworkFSDependency "Hive" ${hiveversion} "hdfsoverlustre" `ls \
        magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupZookeeperNetworkFSDependency "Hive" ${hiveversion} "hdfsovernetworkfs" `ls \
        magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    SetupHDFSoverLustreDependency "Hive" ${hiveversion} `ls \
        magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*`

    SetupHDFSoverNetworkFSDependency "Hive" ${hiveversion} `ls \
        magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-and-hive-DependencyHive-hadoop-${hadoopversion}-hive-${hiveversion}-zookeeper-${zookeeperversion}*`
}

GenerateHiveDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hive Dependency Tests"

    for testfunction in __GenerateHiveDependencyTests_Dependency
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

GenerateHivePostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-hivetestbench*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hivetestbench-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

}
