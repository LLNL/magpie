#!/bin/bash

source test-common.sh
source test-config.sh

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
	for testgroup in ${kafka_test_groups}
	do
	    local zookeeperversion="${testgroup}_zookeeperversion"
	    for testversion in ${!testgroup}
	    do
		${testfunction} ${testversion} ${!zookeeperversion}
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
	for testgroup in ${kafka_test_groups}
	do
	    local zookeeperversion="${testgroup}_zookeeperversion"
	    for testversion in ${!testgroup}
	    do
		${testfunction} ${testversion} ${!zookeeperversion}
	    done
	done
    done
}
