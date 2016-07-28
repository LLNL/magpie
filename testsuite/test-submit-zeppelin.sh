#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitZeppelinStandardTests() {
    local zeppelinversion=$1

    BasicJobSubmit magpie.${submissiontype}-zeppelin
}

SubmitZeppelinTests() {
    for testfunction in __SubmitZeppelinStandardTests
    do
        for testgroup in ${zeppelin_test_groups}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion}
            done
        done
    done
}
