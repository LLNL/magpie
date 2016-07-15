#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateMahoutStandardTests_ClusterSyntheticcontrol() {
    local mahoutversion=$1
    local hadoopversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol-no-local-dir

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*
    
    sed -i -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*

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

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
        -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Mahout1A\/'"${mahoutversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}*hdfsoverlustre*

    sed -i \
        -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
        -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Mahout1A\/'"${mahoutversion}"'"/' \
        magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}*hdfsovernetworkfs*

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
