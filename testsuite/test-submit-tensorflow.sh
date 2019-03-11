#!/bin/bash

source test-common.sh
source test-config.sh

SubmitTensorflowStandardTests() {
    BasicJobSubmit magpie.${submissiontype}-tensorflow-run-tensorflow-tfadd
    BasicJobSubmit magpie.${submissiontype}-tensorflow-run-tensorflow-tfscript
}
