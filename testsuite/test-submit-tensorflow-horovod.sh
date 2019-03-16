#!/bin/bash

source test-common.sh
source test-config.sh

SubmitTensorflowHorovodStandardTests() {
    BasicJobSubmit magpie.${submissiontype}-tensorflow-run-tensorflow-horovod-synthetic
}
