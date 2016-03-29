#!/bin/sh

GenerateMahoutTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Mahout tests"

    for mahoutversion in 0.11.0 0.11.1
    do
	for hadoopversion in 2.7.0
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol-no-local-dir

	    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*

	    sed -i -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*
	done
    done

# Dependency 1 Tests, run after another

    for mahoutversion in 0.11.0 0.11.1
    do
	for hadoopversion in 2.7.0
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol

	    sed -i \
		-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		-e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' \
		-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
		-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Mahout1A\/'"${mahoutversion}"'"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	done
    done

    for mahoutversion in 0.11.0 0.11.1
    do
	for hadoopversion in 2.7.0
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1B-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol

	    sed -i \
		-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		-e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' \
		-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
		-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Mahout1B\/'"${mahoutversion}"'"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1B-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	done
    done
}