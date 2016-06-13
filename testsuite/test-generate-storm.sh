#!/bin/sh

source test-generate-common.sh

GenerateStormStandardTests_StandardWordCount() {
    stormversion=$1
    zookeeperversion=$2
    javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir

    sed -i -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
    
    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*
    
    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*`
}

GenerateStormStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Storm Standard Tests"

    for stormversion in 0.9.3 0.9.4
    do
	if [ "${zookeeper_3_4_6}" != "y" ]
	then
	    echo "Cannot generate Storm standard tests that depend on Zookeeper 3.4.6, it's not enabled"
	    break
	fi
	for zookeeperversion in 3.4.6
	do
	    GenerateStormStandardTests_StandardWordCount ${stormversion} ${zookeeperversion} "1.6"
	done
    done

    for stormversion in 0.9.5 0.9.6 0.10.0
    do
	if [ "${zookeeper_3_4_8}" != "y" ]
	then
	    echo "Cannot generate Storm standard tests that depend on Zookeeper 3.4.8, it's not enabled"
	    break
	fi
	for zookeeperversion in 3.4.8
	do
	    GenerateStormStandardTests_StandardWordCount ${stormversion} ${zookeeperversion} "1.7"
	done
    done
}

GenerateStormDependencyTests_Dependency1() {
    stormversion=$1
    zookeeperversion=$2
    javaversion=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
    
    sed -i \
	-e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' \
	-e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
	-e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
	-e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${zookeeperdatadirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Storm1A\/'"${stormversion}"'\/"/' \
	magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount`
}

GenerateStormDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Storm Dependency Tests"

# Dependency 1 Tests, run after another

    for stormversion in 0.9.3 0.9.4
    do
	if [ "${zookeeper_3_4_6}" != "y" ]
	then
	    echo "Cannot generate Storm dependency tests that depend on Zookeeper 3.4.6, it's not enabled"
	    break
	fi
	for zookeeperversion in 3.4.6
	do
	    GenerateStormDependencyTests_Dependency1 ${stormversion} ${zookeeperversion} "1.6"
	done
    done

    for stormversion in 0.9.5 0.9.6 0.10.0
    do
	if [ "${zookeeper_3_4_8}" != "y" ]
	then
	    echo "Cannot generate Storm dependency tests that depend on Zookeeper 3.4.8, it's not enabled"
	    break
	fi
	for zookeeperversion in 3.4.8
	do
	    GenerateStormDependencyTests_Dependency1 ${stormversion} ${zookeeperversion} "1.7"
	done
    done
}