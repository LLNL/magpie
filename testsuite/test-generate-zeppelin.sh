#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateZeppelinStandardTests_BasicTests() {
    local sparkversion=$1
    local javaversion=$2
    local zeppelinversion=$3
    local zeppelinhome=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    sed -i -e 's|export MAGPIE_JOB_TYPE="\(.*\)"|export MAGPIE_JOB_TYPE="script"|' magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    sed -i -e 's|export SPARK_VERSION="\(.*\)"|export SPARK_VERSION="'"${sparkversion}"'"|' magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    sed -i -e 's|export SPARK_MODE="\(.*\)"|export SPARK_MODE="script"|' magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    sed -i -e 's|# export SPARK_SCRIPT_PATH="\(.*\)"|export SPARK_SCRIPT_PATH="testscripts/test-zeppelin.py"|' magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    sed -i -e 's|export ZEPPELIN_VERSION="\(.*\)"|export ZEPPELIN_VERSION="'"${zeppelinversion}"'"|' magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    sed -i -e 's|export ZEPPELIN_HOME="\(.*\)"|export ZEPPELIN_HOME="'"${zeppelinhome}"'"|' magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-${sparkversion}`

}

GenerateZeppelinStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Zeppelin Standard Tests"

    for testfunction in __GenerateZeppelinStandardTests_BasicTests
    do
        for testgroup in ${zeppelin_test_groups}
        do
            local sparkversion="${testgroup}_sparkversion"
            local javaversion="${testgroup}_javaversion"

            for testversion in ${!testgroup}
            do
                ${testfunction} ${sparkversion} ${javaversion} ${testversion} ${zeppelinhome}
            done
        done
    done
}

GenerateZeppelinPostProcessing () {

}
