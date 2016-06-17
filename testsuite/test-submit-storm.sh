#!/bin/bash

source test-common.sh

SubmitStormStandardTests_StandardWordCount() {
    stormversion=$1
    zookeeperversion=$2

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
    for stormversion in ${stormzookeeper34java16versions}
    do
	for zookeeperversion in 3.4.6
	do
	    SubmitStormStandardTests_StandardWordCount ${stormversion} ${zookeeperversion}
	done
    done
    
    for stormversion in ${stormzookeeper34java17versions}
    do
	for zookeeperversion in 3.4.8
	do
	    SubmitStormStandardTests_StandardWordCount ${stormversion} ${zookeeperversion}
	done
    done
}

SubmitStormDependencyTests_Dependency1() {
    stormversion=$1
    zookeeperversion=$2

    BasicJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
    DependentJobSubmit magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
}

SubmitStormDependencyTests() {
    for stormversion in ${stormzookeeper34java16versions}
    do
	for zookeeperversion in 3.4.6
	do
	    SubmitStormDependencyTests_Dependency1 ${stormversion} ${zookeeperversion}
	done
    done

    for stormversion in ${stormzookeeper34java17versions}
    do
	for zookeeperversion in 3.4.8
	do
	    SubmitStormDependencyTests_Dependency1 ${stormversion} ${zookeeperversion}
	done
    done
}