#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh

GenerateTensorflowHorovodStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Tensorflow Horovod Standard Tests"

    if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-run-tensorflow-horovod-synthetic

        sed -i \
            -e 's/export MAGPIE_PYTHON="\(.*\)"/export MAGPIE_PYTHON="'"${magpiepythontensorflowpathsubst}"'"/; s/#export MAGPIE_TF_SYNTHETIC_BENCHMARK_PARAMETERS=" \\/export MAGPIE_TF_SYNTHETIC_BENCHMARK_PARAMETERS=" --no-cuda --batch-size=32 "\n#export MAGPIE_TF_SYNTHETIC_BENCHMARK_PARAMETERS=" \\/' \
            magpie.${submissiontype}-tensorflow-horovod-run-tensorflow-horovod-synthetic

    fi
}

GenerateTensorflowHorovodPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-tensorflow-horovod-synthetic*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-tf-hv-synthetic-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

