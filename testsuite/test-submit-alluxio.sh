#!/bin/bash

source test-common.sh
source test-config.sh

SubmitAlluxioStandardTests() {
    BasicJobSubmit magpie.${submissiontype}-alluxio-run-testalluxio
}
