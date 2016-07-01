#!/bin/bash

source test-common.sh

SubmitKafkaStandardTests_KafkaPerformance() {
    local kafkaversion=$1
    local zookeeperversion=$2

    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance
    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance
    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance
    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance

    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance-no-local-dir
}

SubmitKafkaStandardTests() {
    for testfunction in SubmitKafkaStandardTests_KafkaPerformance
    do
	for kafkaversion in ${kafkazookeeper34java17versions}
	do
	    for zookeeperversion in ${kafkazookeeper34java17versions_zookeeperversion}
	    do
		${testfunction} ${kafkaversion} ${zookeeperversion}
	    done
	done
    done
}

SubmitKafkaDependencyTests_Dependency1() {
    local kafkaversion=$1
    local zookeeperversion=$2

    BasicJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
    DependentJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
}

SubmitKafkaDependencyTests() {
    for testfunction in SubmitKafkaDependencyTests_Dependency1
    do
	for kafkaversion in ${kafkazookeeper34java17versions}
	do
	    for zookeeperversion in ${kafkazookeeper34java17versions_zookeeperversion}
	    do
		${testfunction} ${kafkaversion} ${zookeeperversion}
	    done
	done
    done
}
