#!/bin/bash

source test-generate-common.sh
source test-common.sh
source test-config.sh
source test-generate-zookeeper-helper.sh

__GenerateKafkaStandardTests_KafkaPerformance() {
    local kafkaversion=$1
    local zookeeperversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-kafkaperformance-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-kafkaperformance-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-kafkaperformance-no-local-dir

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="kafka"/' \
        -e 's/export KAFKA_SETUP=no/export KAFKA_SETUP=yes/' \
        -e 's/export KAFKA_VERSION="\(.*\)"/export KAFKA_VERSION="'"${kafkaversion}"'"/' \
        -e 's/export ZOOKEEPER_SETUP=no/export ZOOKEEPER_SETUP=yes/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*

    SetupZookeeperLocal `ls \
        magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-local*`

    SetupZookeeperNetworkFS `ls \
        magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*`

    SetupZookeeperNotShared `ls \
        magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*`

    SetupZookeeperShared `ls \
        magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*zookeeper-shared*`

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-kafka-${kafkaversion}-zookeeper-${zookeeperversion}*`
}

GenerateKafkaStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Kafka Standard Tests"

    for testfunction in __GenerateKafkaStandardTests_KafkaPerformance
    do
        for testgroup in ${kafka_test_groups}
        do
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Kafka" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

__GenerateKafkaDependencyTests_Dependency1() {
    local kafkaversion=$1
    local zookeeperversion=$2
    local javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype} magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="kafka"/' \
        -e 's/export KAFKA_SETUP=no/export KAFKA_SETUP=yes/' \
        -e 's/export KAFKA_VERSION="\(.*\)"/export KAFKA_VERSION="'"${kafkaversion}"'"/' \
        -e 's/export ZOOKEEPER_SETUP=no/export ZOOKEEPER_SETUP=yes/' \
        -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
        magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance

    SetupZookeeperNetworkFSDependency "Kafka1A" ${kafkaversion} "rawnetworkfs" `ls \
        magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance`

    JavaCommonSubstitution ${javaversion} magpie.${submissiontype}-kafka-DependencyKafka1A-kafka-${kafkaversion}-zookeeper-${zookeeperversion}-run-kafkaperformance
}

GenerateKafkaDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Kafka Dependency Tests"

# Dependency 1 Tests, run after another

    for testfunction in __GenerateKafkaDependencyTests_Dependency1
    do
        for testgroup in ${kafka_test_groups}
        do
            local zookeeperversion="${testgroup}_zookeeperversion"
            local javaversion="${testgroup}_javaversion"
            CheckForDependency "Kafka" "Zookeeper" ${!zookeeperversion}
            for testversion in ${!testgroup}
            do
                ${testfunction} ${testversion} ${!zookeeperversion} ${!javaversion}
            done
        done
    done
}

GenerateKafkaPostProcessing () {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*run-kafkaperformance*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-kafkaperformance-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

