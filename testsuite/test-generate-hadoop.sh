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
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
	
	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
	
	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
    done

# Dependency 2 tests, upgrade hdfs, 2.4.0 -> 2.5.0 -> 2.6.0 -> 2.7.0, HDFS over Lustre / NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopupgradehdfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopupgradehdfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopupgradehdfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	magpie.${submissiontype}-hadoop*DependencyHadoop2A*hdfsoverlustre*

    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
	magpie.${submissiontype}-hadoop*DependencyHadoop2A*hdfsovernetworkfs*

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A*run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A*hdfs-older-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A*run-hadoopupgradehdfs

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A*run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A*hdfs-older-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A*run-hadoopupgradehdfs

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A*run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A*hdfs-older-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A*run-hadoopupgradehdfs

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A*run-hadoopterasort

# Dependency 3 test, increase & decrease size

# decommissionhdfsnodes doesn't work reliably in 2.2.0, removing it
    for hadoopversion in 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
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

# Dependency 4 test, ensure data exists between runs, including increase node size and decrease node size

# decommissionhdfsnodes doesn't work reliably in 2.2.0, removing it
    for hadoopversion in 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A*
    done

# Dependency 5 test, ensure data exists between runs, decommission data filled blocks

# decommissionhdfsnodes doesn't work reliably in 2.2.0, removing it
    for hadoopversion in 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfsoverlustre-run-scriptterasort

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfsovernetworkfs-run-scriptterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*decommissionhdfsnodes*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfsoverlustre-run-scriptterasort

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A-hdfsovernetworkfs-run-scriptterasort

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*hdfsoverlustre*

	sed -i \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5A\/'"${hadoopversion}"'\/"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*hdfsovernetworkfs*
	
	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopteragen.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*scriptteragen*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-hadoopterasort.sh"/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*scriptterasort*

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*decommissionhdfsnodes*
	
	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop5A*
    done

# Dependency 6 test, detect newer hdfs version 2.3.0 from 2.2.0, HDFS over Lustre / NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop6A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop6A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop6A-hdfsoverlustre-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop6A-hdfsoverlustre-hdfs-newer-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop6A-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop6A-hdfsovernetworkfs-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop6A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop6A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

# Dependency 7 test, detect newer hdfs version 2.4.0 from 2.3.0, HDFS over Lustre / NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop7A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop7A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop7A-hdfsoverlustre-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop7A-hdfsoverlustre-hdfs-newer-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop7A-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop7A-hdfsovernetworkfs-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop7A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop7A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

# Dependency 8 test, detect newer hdfs version 2.5.0 from 2.4.0, HDFS over Lustre / NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop8A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop8A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop8A-hdfsoverlustre-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop8A-hdfsoverlustre-hdfs-newer-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop8A-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop8A-hdfsovernetworkfs-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop8A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop8A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

# Dependency 9 test, detect newer hdfs version 2.6.0 from 2.5.0, HDFS over Lustre / NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop9A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop9A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop9A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop9A-hdfsoverlustre-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop9A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop9A-hdfsoverlustre-hdfs-newer-version-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop9A-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop9A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop9A-hdfsovernetworkfs-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop9A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop9A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop9A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

# Dependency 10 test, detect newer hdfs version 2.7.0 from 2.6.0 HDFS over Lustre / NetworkFS

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop10A-hdfsoverlustre-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop10A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop10A-hdfsoverlustre-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop10A-hdfsoverlustre-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop10A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop10A-hdfsoverlustre-hdfs-newer-version-expected-failure
    
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop10A-hdfsovernetworkfs-run-hadoopterasort

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop10A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop10A-hdfsovernetworkfs-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop10A-hdfsovernetworkfs-hdfs-newer-version-expected-failure

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop10A\/"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop10A-hdfsovernetworkfs-hdfs-newer-version-expected-failure
}