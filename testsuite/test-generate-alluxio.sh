#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

__GenerateAlluxioStandardTests_TestAlluxio() {
    local alluxioversion=$1
    local javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-${alluxioversion}-run-testalluxio

    sed -i \
        -e 's/export ALLUXIO_JOB="\(.*\)"/export ALLUXIO_JOB="testalluxio"/' \
        magpie.${submissiontype}-alluxio-${alluxioversion}-run-testalluxio

    sed -i -e 's/export ALLUXIO_VERSION="\(.*\)"/export ALLUXIO_VERSION="'"${alluxioversion}"'"/' magpie.${submissiontype}-alluxio-${alluxioversion}*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-alluxio-${alluxioversion}*`
}

GenerateAlluxioStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Alluxio Standard Tests"

    for testfunction in __GenerateAlluxioStandardTests_TestAlluxio
    do
        for testgroup in ${alluxio_test_groups}
        do
            local javaversion="${testgroup}_javaversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!javaversion}
            done
        done
    done

}

GenerateAlluxioPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-testalluxio"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-testalluxio-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}
