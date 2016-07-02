#!/bin/bash

source test-common.sh
source test-config.sh

SubmitZookeeperStandardTests_RUOK() {
    local zookeeperversion=$1

    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok
	
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir
}

SubmitZookeeperStandardTests() {
    for testfunction in SubmitZookeeperStandardTests_RUOK
    do
	for zookeeperversion in ${zookeeperjava17versions}
	do
	    ${testfunction} ${zookeeperversion}
	done
    done
}

#SubmitZookeeperDependencyTests() {
#    # No Zookeeper Dependency Tests
#}
