#!/bin/bash

source test-common.sh

SubmitZookeeperStandardTests_RUOK() {
    zookeeperversion=$1

    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok
	
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir
}

SubmitZookeeperStandardTests() {
    for zookeeperversion in ${zookeeperjava17versions}
    do
	SubmitZookeeperStandardTests_RUOK ${zookeeperversion}
    done
}

#SubmitZookeeperDependencyTests() {
#    # No Zookeeper Dependency Tests
#}
