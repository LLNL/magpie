#!/bin/bash

source test-common.sh
source test-config.sh

SubmitRayStandardTests() {
    BasicJobSubmit magpie.${submissiontype}-ray-run-ray-rayips
    BasicJobSubmit magpie.${submissiontype}-ray-run-ray-rayscript
}
