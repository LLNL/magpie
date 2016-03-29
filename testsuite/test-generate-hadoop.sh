#!/bin/sh

GenerateHadoopStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hadoop Standard Tests"

# Hadoop Tests
# Note, b/c of MAPREDUCE-5528, not testing rawnetworkfs w/ terasort

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

	sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

	sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*

	sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-single-path*

	sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*

	sed -i -e 's/# export HADOOP_TERASORT_SIZE=\(.*\)/export HADOOP_TERASORT_SIZE=10000000000/' magpie.${submissiontype}-hadoop-${hadoopversion}*largeperformancerun*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

	sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

	sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*

	sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-single-path*

	sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*

	sed -i -e 's/# export HADOOP_TERASORT_SIZE=\(.*\)/export HADOOP_TERASORT_SIZE=10000000000/' magpie.${submissiontype}-hadoop-${hadoopversion}*largeperformancerun*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
    done
}

GenerateHadoopDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Hadoop Dependency Tests"

# Dependency Tests for Hadoop

# Dependency 1 Tests, run after another

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
	
	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
	
	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
    done

# Dependency 2 tests, upgrade hdfs, 2.4.0 -> 2.5.0 -> 2.6.0 -> 2.7.0

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

# Dependency 3 test, increase & decrease size

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	
	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsovernetworkfs*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	
	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*
	
	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsoverlustre*
	
	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsovernetworkfs*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*
    done

# Dependency 4 test, detect newer hdfs version 2.3.0 from 2.2.0, HDFS over Lustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4A-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4A-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4A-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4A-hdfs-newer-version-expected-failure

# Dependency 4 test detect newer hdfs version 2.3.0 from 2.2.0, HDFS over NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4B-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4B-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4B-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4B-hdfs-newer-version-expected-failure

# Dependency 5 test, detect newer hdfs version 2.4.0 from 2.3.0, HDFS over Lustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5A-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5A-hdfs-newer-version-expected-failure

# Dependency 5 test detect newer hdfs version 2.4.0 from 2.3.0, HDFS over NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5B-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5B-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5B-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5B-hdfs-newer-version-expected-failure

# Dependency 6 test, detect newer hdfs version 2.5.0 from 2.4.0, HDFS over Lustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6A-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6A-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6A-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6A-hdfs-newer-version-expected-failure

# Dependency 6 test detect newer hdfs version 2.5.0 from 2.4.0, HDFS over NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6B-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop6B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6B-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6B-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop6B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6B-hdfs-newer-version-expected-failure

# Dependency 7 test, detect newer hdfs version 2.6.0 from 2.5.0, HDFS over Lustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7A-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7A-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7A-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7A-hdfs-newer-version-expected-failure

# Dependency 7 test detect newer hdfs version 2.6.0 from 2.5.0, HDFS over NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7B-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop7B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7B-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7B-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop7B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7B-hdfs-newer-version-expected-failure

# Dependency 8 test, detect newer hdfs version 2.7.0 from 2.6.0 HDFS over Lustre

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8A-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8A-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8A-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8A-hdfs-newer-version-expected-failure
    
# Dependency 8 test, detect newer hdfs version 2.7.0 from 2.6.0 HDFS over NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8B-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop8B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8B-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8B-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop8B\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8B-hdfs-newer-version-expected-failure

# Dependency 9 test, ensure data exists between runs, including increase node size and decrease node size

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop9A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop9A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop9A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop9A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A*
    done

# Dependency 10 test, ensure data exists between runs, decommission data filled blocks

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsoverlustre-run-scriptterasort

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsovernetworkfs-run-scriptterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop10A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop10A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsoverlustre-run-scriptterasort

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsovernetworkfs-run-scriptterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop10A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop10A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*decommissionhdfsnodes*
	
	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A*
    done
}