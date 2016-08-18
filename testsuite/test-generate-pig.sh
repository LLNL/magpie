#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GeneratePigStandardTests_Common() {
    local pigversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript-no-local-dir

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    
    SetupMagpieTestScript "test-pig.sh" `ls \
        magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*`

    SetupHDFSoverLustreStandard `ls \
        magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*hdfsoverlustre*`
    
    SetupHDFSoverNetworkFSStandard `ls \
        magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*hdfsovernetworkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*`
}

GeneratePigStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Pig Standard Tests"

    for testfunction in __GeneratePigStandardTests_Common
    do
        for testgroup in ${pig_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Pig" "Hadoop" ${!hadoopversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done
}

__GeneratePigDependencyTests_Dependency1() {
    local pigversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-no-copy-run-pigscript

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-no-copy-run-pigscript

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}*

    SetupMagpieTestScript "test-pig.sh" `ls \
        magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*`

    sed -i \
        -e 's/export PIG_JOB="\(.*\)"/export PIG_JOB="script"/' \
        -e 's/# export PIG_SCRIPT_PATH="\(.*\)"/export PIG_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pig.pig"/' \
        magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}*no-copy-run-pigscript*
    
    SetupHDFSoverLustreDependency "Pig1A" ${pigversion} `ls \
        magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre*`
    
    SetupHDFSoverNetworkFSDependency "Pig1A" ${pigversion} `ls \
        magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}*`
}

GeneratePigDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Pig Dependency Tests"

# Dependency 1 Tests, run after another, HDFS over Lustre / NetworkFS

    for testfunction in __GeneratePigDependencyTests_Dependency1
    do
        for testgroup in ${pig_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Pig" "Hadoop" ${!hadoopversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done
}

GeneratePigPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-testpig*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-testpig-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-pigscript*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-pigscript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}
