#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

GenerateRayStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Ray Standard Tests"

    if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-ray ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-ray magpie.${submissiontype}-ray-run-ray-rayips
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-ray magpie.${submissiontype}-ray-run-ray-rayscript

        sed -i \
            -e 's/export MAGPIE_PYTHON="\(.*\)"/export MAGPIE_PYTHON="'"${magpiepythonraypathsubst}"'"/' \
            -e 's/export RAY_PATH="\(.*\)"/export RAY_PATH="'"${magpieraypathsubst}"'"/' \
            magpie.${submissiontype}-ray-run-ray*

        sed -i \
            -e 's/export RAY_JOB="\(.*\)"/export RAY_JOB="script"/' \
            -e 's/# export RAY_SCRIPT_PATH="\(.*\)"/export RAY_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-ray.py"/' \
            magpie.${submissiontype}-ray-run-ray-rayscript*
    fi
}

GenerateRayPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-ray-rayips*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-rayips-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-ray-rayscript*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-rayscript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}
