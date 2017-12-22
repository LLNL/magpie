#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateMahoutStandardTests_ClusterSyntheticcontrol() {
    local mahoutversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsoverlustre-run-clustersyntheticcontrol
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsoverlustre-run-clustersyntheticcontrol-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsovernetworkfs-run-clustersyntheticcontrol
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsovernetworkfs-run-clustersyntheticcontrol-no-local-dir

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*

    SetupHDFSoverLustreStandard `ls \
        magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*hdfsoverlustre*`

    SetupHDFSoverNetworkFSStandard `ls \
        magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*hdfsovernetworkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*`
}

GenerateMahoutStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Mahout Standard Tests"

    for testfunction in __GenerateMahoutStandardTests_ClusterSyntheticcontrol
    do
        for testgroup in ${mahout_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Mahout" "Hadoop" ${!hadoopversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done
}

__GenerateMahoutDependencyTests_Dependency1() {
    local mahoutversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsoverlustre-run-clustersyntheticcontrol
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsovernetworkfs-run-clustersyntheticcontrol

    sed -i \
        -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
        -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}*run-clustersyntheticcontrol

    SetupHDFSoverLustreDependency "Mahout1A" ${mahoutversion} `ls \
        magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}*hdfsoverlustre*`

    SetupHDFSoverNetworkFSDependency "Mahout1A" ${mahoutversion} `ls \
        magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}*hdfsovernetworkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}*run-clustersyntheticcontrol`
}

GenerateMahoutDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Mahout Dependency Tests"

# Dependency 1 Tests, run after another

    for testfunction in __GenerateMahoutDependencyTests_Dependency1
    do
        for testgroup in ${mahout_test_groups}
        do
            local hadoopversion="${testgroup}_hadoopversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Mahout" "Hadoop" ${!hadoopversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!hadoopversion} ${!javaversion}
            done
        done
    done
}

GenerateMahoutPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-clustersyntheticcontrol*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-clustersyntheticcontrol-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop-and-mahout*"`
    if [ -n "${files}" ]
    then
        # Guarantee 60 minutes for the job that should last awhile
        ${functiontogettimeoutput} 60
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
    fi
}
