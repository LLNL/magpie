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

GenerateDefaultRegressionTests_CatchProjectDependencies() {
    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-catchprojectdependency-hadoop
	sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hadoop-and-pig-regression-catchprojectdependency-hadoop
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-catchprojectdependency-hadoop
	sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hadoop-and-mahout-regression-catchprojectdependency-hadoop
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-catchprojectdependency-hadoop
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-catchprojectdependency-zookeeper

	sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-regression-catchprojectdependency-hadoop
	sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-regression-catchprojectdependency-zookeeper
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-hadoop
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-hbase
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-zookeeper

	sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-hadoop
	sed -i -e 's/export HBASE_SETUP=\(.*\)/export HBASE_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-hbase
	sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-catchprojectdependency-zookeeper
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-catchprojectdependency-hadoop

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-catchprojectdependency-hadoop

	sed -i \
	    -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
	    magpie.${submissiontype}-spark-with-hdfs-regression-catchprojectdependency-hadoop \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-catchprojectdependency-hadoop

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-regression-catchprojectdependency-hadoop \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-catchprojectdependency-hadoop

	sed -i \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
	    magpie.${submissiontype}-spark-with-hdfs-regression-catchprojectdependency-hadoop \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-catchprojectdependency-hadoop

	sed -i \
	    -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-catchprojectdependency-hadoop

	sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' \
	    magpie.${submissiontype}-spark-with-hdfs-regression-catchprojectdependency-hadoop \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-catchprojectdependency-hadoop
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-catchprojectdependency-zookeeper

	sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-storm-regression-catchprojectdependency-zookeeper
    fi
}

GenerateDefaultRegressionTests_NoSetJava() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-nosetjava
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-nosetjava
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-nosetjava
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-nosetjava
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetjava
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-nosetjava
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-nosetjava
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetjava
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-nosetjava
    fi

    sed -i -e 's/export JAVA_HOME/# export JAVA_HOME/' magpie.${submissiontype}*regression-nosetjava*
}

GenerateDefaultRegressionTests_BadSetJava() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-badsetjava
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-badsetjava
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-badsetjava
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-badsetjava
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsetjava
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-badsetjava
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-badsetjava
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsetjava
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-badsetjava
    fi

    sed -i -e 's/export JAVA_HOME="\(.*\)\"/export JAVA_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}*regression-badsetjava*
}
	    
GenerateDefaultRegressionTests_NoSetVersion() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-nosetversion
	sed -i -e 's/export HADOOP_VERSION/# export HADOOP_VERSION/' magpie.${submissiontype}-hadoop-regression-nosetversion
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-nosetversion
	sed -i -e 's/export PIG_VERSION/# export PIG_VERSION/' magpie.${submissiontype}-hadoop-and-pig-regression-nosetversion
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-nosetversion
	sed -i -e 's/export MAHOUT_VERSION/# export MAHOUT_VERSION/' magpie.${submissiontype}-hadoop-and-mahout-regression-nosetversion
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-nosetversion
	sed -i -e 's/export HBASE_VERSION/# export HBASE_VERSION/' magpie.${submissiontype}-hbase-with-hdfs-regression-nosetversion
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetversion
	sed -i -e 's/export PHOENIX_VERSION/# export PHOENIX_VERSION/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetversion
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-nosetversion
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-nosetversion
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetversion
	sed -i -e 's/export SPARK_VERSION/# export SPARK_VERSION/' \
	    magpie.${submissiontype}-spark-regression-nosetversion \
	    magpie.${submissiontype}-spark-with-hdfs-regression-nosetversion \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetversion
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-nosetversion
	sed -i -e 's/export STORM_VERSION/# export STORM_VERSION/' magpie.${submissiontype}-storm-regression-nosetversion
    fi
}

GenerateDefaultRegressionTests_NoSetHome() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-nosethome
	sed -i -e 's/export HADOOP_HOME/# export HADOOP_HOME/' magpie.${submissiontype}-hadoop-regression-nosethome
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-nosethome
	sed -i -e 's/export PIG_HOME/# export PIG_HOME/' magpie.${submissiontype}-hadoop-and-pig-regression-nosethome
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-nosethome
	sed -i -e 's/export MAHOUT_HOME/# export MAHOUT_HOME/' magpie.${submissiontype}-hadoop-and-mahout-regression-nosethome
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-nosethome
	sed -i -e 's/export HBASE_HOME/# export HBASE_HOME/' magpie.${submissiontype}-hbase-with-hdfs-regression-nosethome
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosethome
	sed -i -e 's/export PHOENIX_HOME/# export PHOENIX_HOME/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosethome
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-nosethome
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-nosethome
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosethome
	sed -i -e 's/export SPARK_HOME/# export SPARK_HOME/' \
	    magpie.${submissiontype}-spark-regression-nosethome \
	    magpie.${submissiontype}-spark-with-hdfs-regression-nosethome \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosethome
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-nosethome
	sed -i -e 's/export STORM_HOME/# export STORM_HOME/' magpie.${submissiontype}-storm-regression-nosethome
    fi
}

GenerateDefaultRegressionTests_BadSetHome() {
    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-badsethome
	sed -i -e 's/export HADOOP_HOME="\(.*\)"/export HADOOP_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-regression-badsethome
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-badsethome
	sed -i -e 's/export PIG_HOME="\(.*\)"/export PIG_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-regression-badsethome
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-badsethome
	sed -i -e 's/export MAHOUT_HOME="\(.*\)"/export MAHOUT_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-mahout-regression-badsethome
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-badsethome
	sed -i -e 's/export HBASE_HOME="\(.*\)"/export HBASE_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-regression-badsethome
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsethome
	sed -i -e 's/export PHOENIX_HOME="\(.*\)"/export PHOENIX_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsethome
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-badsethome
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-badsethome
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsethome
	sed -i -e 's/export SPARK_HOME="\(.*\)"/export SPARK_HOME="\/FOO\/BAR\/BAZ"/' \
	    magpie.${submissiontype}-spark-regression-badsethome \
	    magpie.${submissiontype}-spark-with-hdfs-regression-badsethome \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsethome
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-badsethome
	sed -i -e 's/export STORM_HOME="\(.*\)"/export STORM_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-storm-regression-badsethome
    fi
}

GenerateDefaultRegressionTests_NoSetScript() {
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-regression-nosetscript
    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-magpie-regression-nosetscript

    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-nosetscript
	sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' magpie.${submissiontype}-hadoop-regression-nosetscript
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-nosetscript
	sed -i -e 's/export PIG_MODE="\(.*\)"/export PIG_MODE="script"/' magpie.${submissiontype}-hadoop-and-pig-regression-nosetscript
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-nosetscript
	sed -i -e 's/export MAHOUT_MODE="\(.*\)"/export MAHOUT_MODE="script"/' magpie.${submissiontype}-hadoop-and-mahout-regression-nosetscript
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-nosetscript
	sed -i -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-regression-nosetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetscript
	sed -i -e 's/export PHOENIX_MODE="\(.*\)"/export PHOENIX_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-nosetscript
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-nosetscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-nosetscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetscript
	sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
	    magpie.${submissiontype}-spark-regression-nosetscript \
	    magpie.${submissiontype}-spark-with-hdfs-regression-nosetscript \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-nosetscript
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-nosetscript
	sed -i -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="script"/' magpie.${submissiontype}-storm-regression-nosetscript
    fi
}

GenerateDefaultRegressionTests_BadSetScript() {
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-regression-badsetscript
    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-magpie-regression-badsetscript
    sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\(.*\)"/export MAGPIE_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-regression-badsetscript

    if [ "${hadooptests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-regression-badsetscript
	sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' magpie.${submissiontype}-hadoop-regression-badsetscript
	sed -i -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-regression-badsetscript
    fi

    if [ "${pigtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-regression-badsetscript
	sed -i -e 's/export PIG_MODE="\(.*\)"/export PIG_MODE="script"/' magpie.${submissiontype}-hadoop-and-pig-regression-badsetscript
	sed -i -e 's/# export PIG_SCRIPT_PATH="\(.*\)"/export PIG_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-regression-badsetscript
    fi

    if [ "${mahouttests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-regression-badsetscript
	sed -i -e 's/export MAHOUT_MODE="\(.*\)"/export MAHOUT_MODE="script"/' magpie.${submissiontype}-hadoop-and-mahout-regression-badsetscript
	sed -i -e 's/# export MAHOUT_SCRIPT_PATH="\(.*\)"/export MAHOUT_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-mahout-regression-badsetscript
    fi

    if [ "${hbasetests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-regression-badsetscript
	sed -i -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-regression-badsetscript
	sed -i -e 's/# export HBASE_SCRIPT_PATH="\(.*\)"/export HBASE_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-regression-badsetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsetscript
	sed -i -e 's/export PHOENIX_MODE="\(.*\)"/export PHOENIX_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsetscript
	sed -i -e 's/# export PHOENIX_SCRIPT_PATH="\(.*\)"/export PHOENIX_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-regression-badsetscript
    fi

    if [ "${sparktests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-regression-badsetscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-regression-badsetscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsetscript
	sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
	    magpie.${submissiontype}-spark-regression-badsetscript \
	    magpie.${submissiontype}-spark-with-hdfs-regression-badsetscript \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsetscript
	sed -i -e 's/# export SPARK_SCRIPT_PATH="\(.*\)"/export SPARK_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' \
	    magpie.${submissiontype}-spark-regression-badsetscript \
	    magpie.${submissiontype}-spark-with-hdfs-regression-badsetscript \
	    magpie.${submissiontype}-spark-with-yarn-and-hdfs-regression-badsetscript
    fi

    if [ "${stormtests}" == "y" ]; then
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-regression-badsetscript
	sed -i -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="script"/' magpie.${submissiontype}-storm-regression-badsetscript
	sed -i -e 's/# export STORM_SCRIPT_PATH="\(.*\)"/export STORM_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-storm-regression-badsetscript
    fi
}

GenerateDefaultRegressionTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/
    
    echo "Making Default Regression Tests"

    GenerateDefaultRegressionTests_BadJobNames

    GenerateDefaultRegressionTests_TestAll
    
    GenerateDefaultRegressionTests_InteractiveMode

    GenerateDefaultRegressionTests_JobTimeout

    GenerateDefaultRegressionTests_CatchProjectDependencies

    GenerateDefaultRegressionTests_NoSetJava
    GenerateDefaultRegressionTests_BadSetJava

    GenerateDefaultRegressionTests_NoSetVersion

    GenerateDefaultRegressionTests_NoSetHome
    GenerateDefaultRegressionTests_BadSetHome
    
    GenerateDefaultRegressionTests_NoSetScript
    GenerateDefaultRegressionTests_BadSetScript
}
