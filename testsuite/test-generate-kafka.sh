#!/bin/sh

GenerateKafkaStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Kafka Standard Tests"

    for kafkaversion in 2.11-0.9.0.0
    do
	for zookeeperversion in 3.4.7
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance-no-local-dir

            sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="kafka"/' magpie.${submissiontype}-kafka-*
	    sed -i -e 's/export KAFKA_SETUP=no/export KAFKA_SETUP=yes/' magpie.${submissiontype}-kafka-*
	    sed -i -e 's/export KAFKA_VERSION="\(.*\)"/export KAFKA_VERSION="'"${kafkaversion}"'"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*

	    sed -i -e 's/export ZOOKEEPER_SETUP=no/export ZOOKEEPER_SETUP=yes/' magpie.${submissiontype}-kafka-*
	    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*
	    
	    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	    
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*
	done
    done
}

GenerateKafkaDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Kafka Dependency Tests"

# Dependency 1 Tests, run after another

    for kafkaversion in 2.11-0.9.0.0
    do
	for zookeeperversion in 3.4.7
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} ./magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance

	    sed -i \
		-e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="kafka"/' \
		-e 's/export KAFKA_SETUP=no/export KAFKA_SETUP=yes/' \
		-e 's/export KAFKA_VERSION="\(.*\)"/export KAFKA_VERSION="'"${kafkaversion}"'"/' \
		-e 's/export ZOOKEEPER_SETUP=no/export ZOOKEEPER_SETUP=yes/' \
		-e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		-e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		-e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Kafka1A\/'"${kafkaversion}"'\/"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
	done
    done
}