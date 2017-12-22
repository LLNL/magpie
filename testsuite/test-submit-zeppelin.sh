#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitZeppelinStandardTests_BasicTests() {
    local zeppelinversion=$1
    local sparkversion=$2

    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup
}

SubmitZeppelinStandardTests() {

    for testfunction in __SubmitZeppelinStandardTests_BasicTests
    do
        for testgroup in ${zeppelin_test_groups}
        do
            local sparkversion="${testgroup}_sparkversion"

            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!sparkversion}
            done
        done
    done

}

__SubmitZeppelinDependencyTests_Dependency1() {
    local zeppelinversion=$1
    local sparkversion=$2

    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-DependencyZeppelin1A-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup-notebookdir
    DependentJobSubmit magpie.${submissiontype}-spark-with-zeppelin-DependencyZeppelin1A-zeppelin-${zeppelinversion}-spark-${sparkversion}-run-checkzeppelinup-notebookdir
}

SubmitZeppelinDependencyTests() {

    for testfunction in __SubmitZeppelinDependencyTests_Dependency1
    do
        for testgroup in ${zeppelin_test_groups}
        do
            local sparkversion="${testgroup}_sparkversion"

            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!sparkversion}
            done
        done
    done

}
