#!/bin/bash

source test-common.sh
source test-config.sh

__SubmitZookeeperStandardTests_RUOK() {
    local zookeeperversion=$1

    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok

    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir
}

SubmitZookeeperStandardTests() {
    for testfunction in __SubmitZookeeperStandardTests_RUOK
    do
        for testgroup in ${zookeeper_test_groups}
        do
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion}
            done
        done
    done
}
