#!/bin/sh

SubmitZookeeperStandardTests_RUOK() {
    zookeeperversion=$1

    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok
	
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir
}

SubmitZookeeperStandardTests() {
    for zookeeperversion in 3.4.0 3.4.1 3.4.2 3.4.3 3.4.4 3.4.5 3.4.6 3.4.8
    do
	SubmitZookeeperStandardTests_RUOK ${zookeeperversion}
    done
}

#SubmitZookeeperDependencyTests() {
#    # No Zookeeper Dependency Tests
#}
