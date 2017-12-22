#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh
source test-generate-zookeeper-helper.sh

__GenerateStormStandardTests_StandardWordCount() {
    local stormversion=$1
    local zookeeperversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir

    sed -i \
        -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*

    SetupZookeeperLocal `ls \
        magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*`

    SetupZookeeperNetworkFS `ls \
        magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*`

    SetupZookeeperNotShared `ls \
        magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*`

    SetupZookeeperShared `ls \
        magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-shared*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*`
}

GenerateStormStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Storm Standard Tests"

    for testfunction in __GenerateStormStandardTests_StandardWordCount
    do
        for testgroup in ${storm_test_groups}
        do
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Storm" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

__GenerateStormDependencyTests_Dependency1() {
    local stormversion=$1
    local zookeeperversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount

    sed -i \
        -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount

    SetupZookeeperNetworkFSDependency "Storm1A" ${stormversion} "rawnetworkfs" `ls \
        magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount`
}

GenerateStormDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Storm Dependency Tests"

# Dependency 1 Tests, run after another

    for testfunction in __GenerateStormDependencyTests_Dependency1
    do
        for testgroup in ${storm_test_groups}
        do
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Storm" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

GenerateStormPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-stormwordcount*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-stormwordcount-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-storm*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my node count>/${basenodeszookeepernodescount}/" ${files}
    fi
}

