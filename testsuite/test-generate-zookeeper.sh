#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateZookeeperStandardTests_RUOK() {
    local zookeeperversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir

    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    SetupZookeeperLocal `ls \
        magpie.${submissiontype}-zookeeper-${zookeeperversion}*zookeeper-local*`

    SetupZookeeperNetworkFS `ls \
        magpie.${submissiontype}-zookeeper-${zookeeperversion}*zookeeper-networkfs*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-zookeeper-${zookeeperversion}*`
}

GenerateZookeeperStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/
    
    echo "Making Zookeeper Standard Tests"

    for testfunction in __GenerateZookeeperStandardTests_RUOK
    do
        for testgroup in ${zookeeper_test_groups}
        do
            local javaversion="${testgroup}_javaversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!javaversion}
            done
        done
    done
}

GenerateZookeeperPostProcessing () {

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-zookeeperruok*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-zookeeperruok-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*zookeeper-shared*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-shared-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*" | grep -v Dependency`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export ZOOKEEPER_PER_JOB_DATA_DIR="\(.*\)"/export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/' ${files}
    fi
}
