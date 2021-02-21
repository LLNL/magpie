#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateZeppelinStandardTests_BasicTests() {
    local zeppelinversion=$1
    local sparkversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup

    sed -i \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export ZEPPELIN_VERSION="\(.*\)"/export ZEPPELIN_VERSION="'"${zeppelinversion}"'"/' \
        magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup`
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
            if ! CheckForDependency "Zeppelin" "Spark" ${!sparkversion}
            then
                continue
            fi
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!sparkversion} ${!javaversion}
            done
        done
    done
}

__GenerateZeppelinDependencyTests_Dependency1() {
    local zeppelinversion=$1
    local sparkversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-DependencyZeppelin1A-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup-notebookdir

    sed -i \
        -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
        -e 's/export ZEPPELIN_VERSION="\(.*\)"/export ZEPPELIN_VERSION="'"${zeppelinversion}"'"/' \
        magpie.${submissiontype}-spark-with-zeppelin-DependencyZeppelin1A-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup-notebookdir

    sed -i \
        -e 's/# export ZEPPELIN_NOTEBOOK_DIR/export ZEPPELIN_NOTEBOOK_DIR/' \
        magpie.${submissiontype}-spark-with-zeppelin-DependencyZeppelin1A-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup-notebookdir

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-zeppelin-DependencyZeppelin1A-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup-notebookdir`
}

GenerateZeppelinDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Zeppelin Dependency Tests"

# Dependency 1 Tests, run after another

    for testfunction in __GenerateZeppelinDependencyTests_Dependency1
    do
        for testgroup in ${zeppelin_test_groups}
        do
            local sparkversion="${testgroup}_sparkversion"
            local javaversion="${testgroup}_javaversion"
            if ! CheckForDependency "Zeppelin" "Spark" ${!sparkversion}
            then
                continue
            fi
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!sparkversion} ${!javaversion}
            done
        done
    done
}

GenerateZeppelinPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-checkzeppelinup*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-checkzeppelinup-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}
