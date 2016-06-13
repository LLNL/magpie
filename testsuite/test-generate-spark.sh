#!/bin/sh

source test-generate-common.sh

GenerateSparkStandardTests_BasicTests() {
    sparkversion=$1
    javaversion=$2
    localdirtests=$3

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-pysparkwordcount

    if [ "${localdirtests}" == "y" ]
    then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-pysparkwordcount-no-local-dir
    fi
	
    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*
    
    sed -i \
	-e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
	-e 's/# export SPARK_SCRIPT_PATH="\(.*\)"/export SPARK_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-pyspark.sh"/' \
	magpie.${submissiontype}-spark-${sparkversion}-run-pysparkwordcount*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-${sparkversion}*`
}

GenerateSparkStandardTests_WordCount() {
    sparkversion=$1
    hadoopversion=$2
    javaversion=$3
    localdirtests=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-sparkwordcount-copy-in

    if [ "${localdirtests}" == "y" ]
    then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-sparkwordcount-copy-in-no-local-dir
    fi

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}* magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs*

    sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}* magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*
    sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*
    sed -i -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}*

    sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}* magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}*`
}

GenerateSparkStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Spark Standard Tests"

# Basic tests

    # 0.9.X no local dir tests
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
    do
	GenerateSparkStandardTests_BasicTests ${sparkversion} "1.6" "n"
    done

    for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
	GenerateSparkStandardTests_BasicTests ${sparkversion} "1.6" "y"
    done

    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
    do
	GenerateSparkStandardTests_BasicTests ${sparkversion} "1.7" "y"
    done

# Spark w/ HDFS & Rawnetworkfs tests

    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
    do
	for hadoopversion in 2.2.0
	do
	    GenerateSparkStandardTests_WordCount ${sparkversion} ${hadoopversion} "1.6" "n"
	done
    done

    for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
	for hadoopversion in 2.4.0
	do
	    GenerateSparkStandardTests_WordCount ${sparkversion} ${hadoopversion} "1.6" "y"
	done
    done

    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
    do
	for hadoopversion in 2.6.0
	do
	    GenerateSparkStandardTests_WordCount ${sparkversion} ${hadoopversion} "1.7" "y"
	done
    done
}

GenerateSparkDependencyTests_Dependency1HDFS() {
    sparkversion=$1
    hadoopversion=$2
    javaversion=$3
    decommission=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    if [ "${decommission}" == "y" ]
    then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes
    fi

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    if [ "${decommission}" == "y" ]
    then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes
    fi

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*
    
    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsoverlustre*

    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsovernetworkfs*

    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-no-copy*

    # Need to set to get through magpie-check-inputs
    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfs-fewer-nodes*expected-failure

    if [ "${decommission}" == "y" ]
    then
	sed -i \
	    -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    -e 's/export SPARK_SETUP=yes/export SPARK_SETUP=no/' \
	    magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*decommissionhdfsnodes*
    fi

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}*`
}

GenerateSparkDependencyTests_Dependency2HDFS() {
    sparkversion=$1
    hadoopversion=$2
    javaversion=$3
    decommission=$4

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    if [ "${decommission}" == "y" ]
    then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    fi

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    if [ "${decommission}" == "y" ]
    then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    fi

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*
    
    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark2A\/'"${sparkversion}"'"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsoverlustre*

    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark2A\/'"${sparkversion}"'"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfsovernetworkfs*

    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*run-sparkwordcount-no-copy*

	# Need to set to get through magpie-check-inputs
    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*hdfs-fewer-nodes*expected-failure

    if [ "${decommission}" == "y" ]
    then
	sed -i \
	    -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hadoop"/' \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' \
	    -e 's/# export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=.*/export HADOOP_DECOMMISSION_HDFS_NODE_SIZE=8/' \
	    -e 's/export SPARK_SETUP=yes/export SPARK_SETUP=no/' \
	    magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*decommissionhdfsnodes*
    fi

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}*`
}

GenerateSparkDependencyTests_Dependency3rawnetworkfs() {
    sparkversion=$1
    javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy

    sed -i \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}*

    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark3A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}*run-sparkwordcount-copy-in*

    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark3A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}*run-sparkwordcount-no-copy*

    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}*`
}

GenerateSparkDependencyTests_Dependency4rawnetworkfs() {
    sparkversion=$1
    javaversion=$2

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-copy-in
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}-run-sparkwordcount-no-copy
    
    sed -i \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}*
    
    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark4A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}*run-sparkwordcount-copy-in*
    
    sed -i \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark4A\/'"${sparkversion}"'\/test-wordcountfile\"/' \
	magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}*run-sparkwordcount-no-copy*
    
    JavaCommonSubstitution ${javaversion} `ls magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}*`
}

GenerateSparkDependencyTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Spark Dependency Tests"

# Dependency 1 Tests, run after another, HDFS over Lustre/Networkfs

# No decommissionhdfsnodes for Hadoop 2.2.0
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
    do
	for hadoopversion in 2.2.0
	do
	    GenerateSparkDependencyTests_Dependency1HDFS ${sparkversion} ${hadoopversion} "1.6" "n"
	done
    done

    for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
	for hadoopversion in 2.4.0
	do
	    GenerateSparkDependencyTests_Dependency1HDFS ${sparkversion} ${hadoopversion} "1.6" "y"
	done
    done

    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
    do
	for hadoopversion in 2.6.0
	do
	    GenerateSparkDependencyTests_Dependency1HDFS ${sparkversion} ${hadoopversion} "1.7" "y"
	done
    done

# Dependency 2 Tests, run after another, start with more nodes, HDFS over Lustre/Networkfs

# No decommissionhdfsnodes for Hadoop 2.2.0
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
    do
	for hadoopversion in 2.2.0
	do
	    GenerateSparkDependencyTests_Dependency2HDFS ${sparkversion} ${hadoopversion} "1.6" "n"
	done
    done

    for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
	for hadoopversion in 2.4.0
	do
 	    GenerateSparkDependencyTests_Dependency2HDFS ${sparkversion} ${hadoopversion} "1.6" "y"
	done
    done

    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
    do
	for hadoopversion in 2.6.0
	do
 	    GenerateSparkDependencyTests_Dependency2HDFS ${sparkversion} ${hadoopversion} "1.7" "y"
 	done
    done

# Dependency 3 Tests, run after another, rawnetworkfs
    
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
	GenerateSparkDependencyTests_Dependency3rawnetworkfs ${sparkversion} "1.6"
    done

    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
    do
	GenerateSparkDependencyTests_Dependency3rawnetworkfs ${sparkversion} "1.7"
    done


# Dependency 4 Tests, run after another, start with more nodes, rawnetworkfs
    
    for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
    do
	GenerateSparkDependencyTests_Dependency4rawnetworkfs ${sparkversion} "1.6"
    done

    for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
    do
	GenerateSparkDependencyTests_Dependency4rawnetworkfs ${sparkversion} "1.7"
    done
}
