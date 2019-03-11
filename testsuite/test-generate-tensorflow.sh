#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

GenerateTensorflowStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Tensorflow Standard Tests"

    if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-run-tensorflow-tfadd
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-run-tensorflow-tfscript

        sed -i \
            -e 's/export MAGPIE_PYTHON="\(.*\)"/export MAGPIE_PYTHON="'"${magpiepythontensorflowpathsubst}"'"/' \
            magpie.${submissiontype}-tensorflow-run-tensorflow*

        sed -i \
            -e 's/export TENSORFLOW_JOB="\(.*\)"/export TENSORFLOW_JOB="script"/' \
            -e 's/# export TENSORFLOW_SCRIPT_PATH="\(.*\)"/export TENSORFLOW_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-tensorflow.py"/' \
            magpie.${submissiontype}-tensorflow-run-tensorflow-tfscript*
    fi
}

GenerateTensorflowPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-tensorflow-tfadd*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-tfadd-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-tensorflow-tfscript*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-tfscript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}
