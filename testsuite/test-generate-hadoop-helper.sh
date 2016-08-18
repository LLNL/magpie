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
