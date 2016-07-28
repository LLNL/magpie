#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateZeppelinStandardTests_BasicTests() {
    local sparkversion=$1
    local javaversion=$2
    local zeppelinversion=$3
    local zeppelinhome=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-zeppelin magpie.${submissiontype}-zeppelin

    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-zeppelin

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-zeppelin

    sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' magpie.${submissiontype}-zeppelin

    sed -i -e 's|# export SPARK_SCRIPT_PATH="\(.*\)"|export SPARK_SCRIPT_PATH="testscripts/test-zeppelin.py"|' magpie.${submissiontype}-zeppelin

    sed -i -e 's/export ZEPPELIN_SETUP=no/export ZEPPELIN_SETUP=yes/' magpie.${submissiontype}-zeppelin

    sed -i -e 's/export ZEPPELIN_VERSION="\(.*\)"/export ZEPPELIN_VERSION="'"${zeppelinversion}"'"/' magpie.${submissiontype}-zeppelin

    sed -i -e 's|export ZEPPELIN_HOME="\(.*\)"|export ZEPPELIN_HOME="'"${zeppelinhome}"'"|' magpie.${submissiontype}-zeppelin

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-zeppelin`

}

GenerateZeppelinStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    local sparkversion="1.5.2-bin-hadoop2.6"
    local javaversion=${java17}

    echo "Making Zeppelin Standard Tests"

    for testfunction in __GenerateZeppelinStandardTests_BasicTests
    do
        for testgroup in ${zeppelin_test_groups}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${sparkversion} ${javaversion} ${testversion} ${zeppelinhome}
            done
        done
    done
}

GenerateZookeeperPostProcessing () {

}
