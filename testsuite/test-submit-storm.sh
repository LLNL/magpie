#!/bin/bash

source test-common.sh
source test-config.sh

SubmitStormStandardTests_StandardWordCount() {
    local stormversion=$1
    local zookeeperversion=$2

    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount

    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir
}

SubmitStormStandardTests() {
    for testfunction in SubmitStormStandardTests_StandardWordCount
    do
        for testgroup in ${storm_test_groups}
        do
            local zookeeperversion="${testgroup}_zookeeperversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!zookeeperversion}
            done
        done
    done
}

SubmitStormDependencyTests_Dependency1() {
    local stormversion=$1
    local zookeeperversion=$2

    BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
    DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
}

SubmitStormDependencyTests() {
    for testfunction in SubmitStormDependencyTests_Dependency1
    do
        for testgroup in ${storm_test_groups}
        do
            local zookeeperversion="${testgroup}_zookeeperversion"
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!zookeeperversion}
            done
        done
    done
}