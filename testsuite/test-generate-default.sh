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

GenerateDefaultRegressionTests_BadJobNames() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-job-name-dollarsign
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-job-name-dollarsign
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-job-name-dollarsign
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-job-name-dollarsign
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-job-name-dollarsign
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-regression-job-name-dollarsign
	
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name-dollarsign

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name-dollarsign

	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name* \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name*

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name* \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name*

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-job-name* \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name*
	sed -i \
	    -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-job-name*
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-regression-job-name-whitespace
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-regression-job-name-dollarsign
    fi

    # Some job scripts use environment variable, some use command line
    # options.  So check for quoted situation first.  If no quotes,
    # add them.
    sed -i -e 's/\"<my job name>\"/test job/' magpie.${submissiontype}*regression-job-name-whitespace
    sed -i -e 's/<my job name>/\"test job\"/' magpie.${submissiontype}*regression-job-name-whitespace

    sed -i -e 's/\"<my job name>\"/test$job/' magpie.${submissiontype}*regression-job-name-dollarsign
    sed -i -e 's/<my job name>/test$job/' magpie.${submissiontype}*regression-job-name-dollarsign
}

GenerateDefaultRegressionTests_AltConfFilesDir() {

    # Just set to the current CONF_DIR to make sure setting it works

    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-altconffilesdir
	sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-altconffilesdir
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-altconffilesdir
	sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-altconffilesdir
	sed -i -e 's/# export PIG_CONF_FILES="\(.*\)"/export PIG_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-pig-run-testpig-regression-altconffilesdir
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-altconffilesdir
	sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-regression-altconffilesdir
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export HBASE_CONF_FILES="\(.*\)"/export HBASE_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-regression-altconffilesdir
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export HBASE_CONF_FILES="\(.*\)"/export HBASE_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export PHOENIX_CONF_FILES="\(.*\)"/export PHOENIX_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-altconffilesdir
	sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-regression-altconffilesdir
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-regression-altconffilesdir
	
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir

	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir
	sed -i \
	    -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir

	sed -i \
	    -e 's/# export SPARK_CONF_FILES="\(.*\)"/export SPARK_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' \
	    magpie.${submissiontype}-spark-run-sparkpi-regression-altconffilesdir \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir

	sed -i \
	    -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' \
	    magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-regression-altconffilesdir
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-regression-altconffilesdir
	sed -i -e 's/# export STORM_CONF_FILES="\(.*\)"/export STORM_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-storm-run-stormwordcount-regression-altconffilesdir
	sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-storm-run-stormwordcount-regression-altconffilesdir
    fi
}

GenerateDefaultRegressionTests_TestAll() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-regression-testall
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-hadoopterasort-run-testpig-regression-testall
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-hadoopterasort-run-clustersyntheticcontrol-regression-testall
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-run-zookeeperruok-regression-testall
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-hbaseperformanceeval-run-phoenixperformanceeval-run-zookeeperruok-regression-testall
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-regression-testall
	
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkpi-regression-testall

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkpi-regression-testall

	sed -i \
	    -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkpi-regression-testall
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-run-zookeeperruok-regression-testall
    fi

    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="testall"/' magpie.${submissiontype}*regression-testall
}

GenerateDefaultRegressionTests_InteractiveMode() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-interactive-mode

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="interactive"/' \
	    magpie.${submissiontype}-hadoop-regression-interactive-mode
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-interactive-mode
	sed -i \
	    -e 's/export PIG_MODE="\(.*\)"/export PIG_MODE="interactive"/' \
	    magpie.${submissiontype}-hadoop-and-pig-regression-interactive-mode
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-interactive-mode

	sed -i \
	    -e 's/export MAHOUT_MODE="\(.*\)"/export MAHOUT_MODE="interactive"/' \
	    magpie.${submissiontype}-hadoop-and-mahout-regression-interactive-mode
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-interactive-mode

	sed -i \
	    -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="interactive"/' \
	    magpie.${submissiontype}-hbase-with-hdfs-regression-interactive-mode
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-interactive-mode

	sed -i \
	    -e 's/export PHOENIX_MODE="\(.*\)"/export PHOENIX_MODE="interactive"/' \
	    magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-interactive-mode
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-interactive-mode
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-interactive-mode
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-interactive-mode
	
	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="interactive"/' \
	    magpie.${submissiontype}-spark-regression-interactive-mode \
	    magpie.${submissiontype}-spark-with-hdfs-regression-interactive-mode \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-interactive-mode
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-interactive-mode

	sed -i \
	    -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="interactive"/' \
	    magpie.${submissiontype}-storm-regression-interactive-mode
    fi
}

GenerateDefaultRegressionTests_JobTimeout() {
    
    # timeoutputforjob returned
    GetSecondsJob 30

    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-jobtimeout

	sed -i \
	    -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' \
	    -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-sleep.sh"/' \
	    -e 's/# export HADOOP_SCRIPT_ARGS="\(.*\)"/export HADOOP_SCRIPT_ARGS="\-s '"${timeoutputforjob}"'"/' \
	    magpie.${submissiontype}-hadoop-regression-jobtimeout
    fi

    # No Pig test, "script" in Pig executes via a pig command
    
    # No Mahout test, "script" in Mahout executes via a mahout command

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-jobtimeout

	sed -i \
	    -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="script"/' \
	    -e 's/# export HBASE_SCRIPT_PATH="\(.*\)"/export HBASE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-sleep.sh"/' \
	    -e 's/# export HBASE_SCRIPT_ARGS="\(.*\)"/export HBASE_SCRIPT_ARGS="\-s '"${timeoutputforjob}"'"/' \
	    magpie.${submissiontype}-hbase-with-hdfs-regression-jobtimeout
    fi

    # No Phoenix test, "script" in Phoenix executes via a phoenix command

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-jobtimeout
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-jobtimeout
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-jobtimeout
	
	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
	    -e 's/# export SPARK_SCRIPT_PATH="\(.*\)"/export SPARK_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-sleep.sh"/' \
 	    -e 's/# export SPARK_SCRIPT_ARGS="\(.*\)"/export SPARK_SCRIPT_ARGS="\-s '"${timeoutputforjob}"'"/' \
	    magpie.${submissiontype}-spark-regression-jobtimeout \
	    magpie.${submissiontype}-spark-with-hdfs-regression-jobtimeout \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-jobtimeout
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-jobtimeout

	sed -i \
	    -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="script"/' \
	    -e 's/# export STORM_SCRIPT_PATH="\(.*\)"/export STORM_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/test-sleep.sh"/' \
 	    -e 's/# export STORM_SCRIPT_ARGS="\(.*\)"/export STORM_SCRIPT_ARGS="\-s '"${timeoutputforjob}"'"/' \
	    magpie.${submissiontype}-storm-regression-jobtimeout
    fi
}

GenerateDefaultRegressionTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/
    
    echo "Making Default Regression Tests"

    GenerateDefaultRegressionTests_BadJobNames

    GenerateDefaultRegressionTests_AltConfFilesDir

    GenerateDefaultRegressionTests_TestAll
    
    GenerateDefaultRegressionTests_InteractiveMode

    GenerateDefaultRegressionTests_JobTimeout
}
