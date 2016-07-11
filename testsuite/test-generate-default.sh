#!/bin/bash

source test-generate-common.sh
source test-config.sh

GenerateDefaultStandardTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Default Standard Tests"

# Default Tests

    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort
    fi
    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig
    fi
    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol
    fi
    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval
    fi
    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval
    fi
    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in

	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in
	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in
	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in
	sed -i \
	    -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in
    fi
    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount
    fi
    if [ "${zookeepertests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-run-zookeeperruok

	sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-run-zookeeperruok
	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok
	sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok
    fi

# Default No Local Dir Tests

    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-no-local-dir
    fi
    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-no-local-dir
    fi
    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-no-local-dir
    fi
    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-no-local-dir
    fi
    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-no-local-dir
    fi
    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-no-local-dir

	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-no-local-dir \
 	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-no-local-dir

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-no-local-dir \
 	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-no-local-dir

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-no-local-dir \
 	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-no-local-dir
	sed -i \
	    -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-no-local-dir
    fi
    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-no-local-dir
    fi
    if [ "${zookeepertests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir

	sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
	sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
    fi
}
