#!/bin/sh

SubmitKafkaTests() {
    if [ "${kafkatests}" == "y" ]
    then
	if [ "${standardtests}" == "y" ]
	then
	    for kafkaversion in 2.11-0.9.0.0
	    do
		for zookeeperversion in 3.4.7
		do
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance

                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance-no-local-dir
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
                    BasicJobSubmit magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance-no-local-dir
		done
	    done
	fi

	if [ "${dependencytests}" == "y" ]
	then
	    for kafkaversion in 2.11-0.9.0.0
	    do
		for zookeeperversion in 3.4.7
		do
		    BasicJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
		    DependentJobSubmit magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
		done
	    done
	fi
    fi
}