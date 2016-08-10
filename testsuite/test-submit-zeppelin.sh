#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitZeppelinStandardTests_BasicTests() {
    local zeppelinversion=$1
    local sparkversion=$1

    BasicJobsubmit magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-spark-${sparkversion}
}

SubmitZeppelinStandardTests() {

    for testfunction in __SubmitZeppelinStandardTests_BasicTests
    do
        for testgroup in ${zeppelin_test_groups}
        do
            local sparkversion="${testgroup}_sparkversion"

            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${sparkversion}
            done
        done
    done

}

SubmitZeppelinDependencyTests() {

}
