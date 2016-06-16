#!/bin/bash

SubmitKafkaStandardTests_KafkaPerformance() {
    kafkaversion=$1
    zookeeperversion=$2

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
    for kafkaversion in 2.11-0.9.0.0
    do
	for zookeeperversion in 3.4.8
	do
	    SubmitKafkaStandardTests_KafkaPerformance ${kafkaversion} ${zookeeperversion}
	done
    done
}

SubmitKafkaDependencyTests_Dependency1() {
    kafkaversion=$1
    zookeeperversion=$2

    BasicJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
    DependentJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
}

SubmitKafkaDependencyTests() {
    for kafkaversion in 2.11-0.9.0.0
    do
	for zookeeperversion in 3.4.8
	do
	    SubmitKafkaDependencyTests_Dependency1 ${kafkaversion} ${zookeeperversion}
	done
    done
}
