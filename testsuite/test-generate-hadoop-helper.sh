#!/bin/bash

source test-common.sh
source test-config.sh
source ../magpie/lib/magpie-lib-helper

CheckForHadoopDecomissionMinimum() {
    local testfunction=$1
    local project=$2
    local projectcheck=$3
    local projectversion=$4
    local projectminimum=$5

    if echo ${testfunction} | grep -q "requiredecommissionhdfs"
    then
        # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
        Magpie_vercomp ${projectversion} ${projectminimum}
        if [ $? == "2" ]
        then
            #echo "Cannot generate ${project} tests that depend on ${projectcheck} ${projectversion}, minimum needed for tests is ${projectminimum}"
            continue
        fi
    fi
}

__SetupHadoopFileSystemStandard() {
    local fstype=$1
    shift
    local files=$@

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="'"${fstype}"'"/' \
        ${files}
}

SetupHDFSoverLustreStandard() {
    __SetupHadoopFileSystemStandard "hdfsoverlustre" $@
}

SetupHDFSoverNetworkFSStandard() {
    __SetupHadoopFileSystemStandard "hdfsovernetworkfs" $@
}

SetupRawnetworkFSStandard() {
    __SetupHadoopFileSystemStandard "rawnetworkfs" $@
}

SetupHDFSoverLustreDependency() {
    local dependencystr=$1
    shift
    local projectversion=$1
    shift
    local files=$@

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/'"${dependencystr}"'\/'"${projectversion}"'\/"/' \
        ${files}
}

SetupHDFSoverNetworkFSDependency() {
    local dependencystr=$1
    shift
    local projectversion=$1
    shift
    local files=$@

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/'"${dependencystr}"'\/'"${projectversion}"'\/"/' \
        ${files}
}

SetupRawnetworkFSDependency() {
    local dependencystr=$1
    shift
    local projectversion=$1
    shift
    local files=$@

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' \
        -e 's/export HADOOP_RAWNETWORKFS_PATH="\(.*\)"/export HADOOP_RAWNETWORKFS_PATH="'"${rawnetworkfsdirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/'"${dependencystr}"'\/'"${projectversion}"'\/\"/' \
        ${files}
}

SetupHadoopDecommissionHDFSNodes() {
    local files=$@

    # Extra SETUP disables just in case

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
        -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="decommissionhdfsnodes"/' \
        -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE='"${basenodecount}"'/' \
        -e 's/export HBASE_SETUP=\(.*\)/export HBASE_SETUP=no/' \
        -e 's/export SPARK_SETUP=\(.*\)/export SPARK_SETUP=no/' \
        ${files}
}
