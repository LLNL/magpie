#!/bin/bash

source test-generate-common.sh
source test-config.sh
source test-generate-spark-helper.sh

__GenerateCornerCaseTests_CatchProjectDependencies() {
    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hadoop-and-pig-cornercase-catchprojectdependency-hadoop
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-hadoop
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-zookeeper

        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-zookeeper
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-catchprojectdependency-hadoop
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-catchprojectdependency-zookeeper

        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hadoop-and-hive-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-hadoop-and-hive-cornercase-catchprojectdependency-zookeeper
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hadoop
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hbase
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-zookeeper

        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export HBASE_SETUP=\(.*\)/export HBASE_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hbase
        sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-zookeeper
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-catchprojectdependency-hadoop

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-cornercase-catchprojectdependency-hadoop`

        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-catchprojectdependency-zookeeper

        sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-storm-cornercase-catchprojectdependency-zookeeper
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-catchprojectdependency-spark

        sed -i -e 's/export SPARK_SETUP=\(.*\)/export SPARK_SETUP=no/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-catchprojectdependency-spark
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-catchprojectdependency*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/catchprojectdependency-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoSetJava() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nosetjava
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetjava
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetjava
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetjava
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetjava
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-nosetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetjava
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosetjava
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetjava
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-nosetjava
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosetjava*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export JAVA_HOME/# export JAVA_HOME/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetjava-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadSetJava() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badsetjava
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetjava
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetjava
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badsetjava
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetjava
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badsetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badsetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badsetjava
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetjava
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badsetjava
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badsetjava
    fi

    if [ "${alluxio}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badsetjava
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badsetjava*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export JAVA_HOME="\(.*\)\"/export JAVA_HOME="\/FOO\/BAR\/BAZ"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetjava-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoSetPython() {
    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-nosetpython
        fi
    fi
    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-nosetpython
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosetpython*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export MAGPIE_PYTHON/# export MAGPIE_PYTHON/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetpython-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadSetPython() {
    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-badsetpython
        fi
    fi
    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badsetpython
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badsetpython*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export MAGPIE_PYTHON="\(.*\)\"/export MAGPIE_PYTHON="\/FOO\/BAR\/BAZ"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetpython-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoSetVersion() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nosetversion
        sed -i -e 's/export HADOOP_VERSION/# export HADOOP_VERSION/' magpie.${submissiontype}-hadoop-cornercase-nosetversion
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetversion
        sed -i -e 's/export PIG_VERSION/# export PIG_VERSION/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetversion
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetversion
        sed -i -e 's/export HBASE_VERSION/# export HBASE_VERSION/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetversion
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetversion
        sed -i -e 's/export HIVE_VERSION/# export HIVE_VERSION/' magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetversion
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetversion
        sed -i -e 's/export PHOENIX_VERSION/# export PHOENIX_VERSION/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetversion
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
        sed -i -e 's/export SPARK_VERSION/# export SPARK_VERSION/' \
            magpie.${submissiontype}-spark-cornercase-nosetversion \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-nosetversion \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetversion \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nosetversion \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosetversion
        sed -i -e 's/export STORM_VERSION/# export STORM_VERSION/' magpie.${submissiontype}-storm-cornercase-nosetversion
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nosetversion
        sed -i -e 's/export ZOOKEEPER_VERSION/# export ZOOKEEPER_VERSION/' magpie.${submissiontype}-zookeeper-cornercase-nosetversion
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetversion
        sed -i -e 's/export ZEPPELIN_VERSION/# export ZEPPELIN_VERSION/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetversion
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-nosetversion
        sed -i -e 's/export ALLUXIO_VERSION/# export ALLUXIO_VERSION/' magpie.${submissiontype}-alluxio-cornercase-nosetversion
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosetversion*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetversion-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadVersion() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2"/' magpie.${submissiontype}-hadoop-cornercase-badversion

        # 0.2X are early builds of Hadoop, we no longer support

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-1
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="0.20.2"/' magpie.${submissiontype}-hadoop-cornercase-badversion-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-2
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="0.23.20"/' magpie.${submissiontype}-hadoop-cornercase-badversion-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-3
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="0.24."/' magpie.${submissiontype}-hadoop-cornercase-badversion-3

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-4
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="1.0.0"/' magpie.${submissiontype}-hadoop-cornercase-badversion-4

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-5
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="1.0.1"/' magpie.${submissiontype}-hadoop-cornercase-badversion-5

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-6
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="1.2.0"/' magpie.${submissiontype}-hadoop-cornercase-badversion-6

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-7
        sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="decommissionhdfsnodes"/' magpie.${submissiontype}-hadoop-cornercase-badversion-7
        sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' magpie.${submissiontype}-hadoop-cornercase-badversion-7

        # Earliest version of 'upgradehdfs' supported in this testsuite is 2.2.0, so any earlier version will fail because HADOOP_HOME
        # directory cannot be found.  Skip creation of this test
        # cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badversion-8
        # sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="upgradehdfs"/' magpie.${submissiontype}-hadoop-cornercase-badversion-8
        # sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.1.0"/' magpie.${submissiontype}-hadoop-cornercase-badversion-8
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badversion
        sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="2.2"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badversion
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badversion
        sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="2.2"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badversion
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badversion
        sed -i -e 's/export HIVE_VERSION="\(.*\)"/export HIVE_VERSION="2.2"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badversion
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badversion
        sed -i -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="2.2"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badversion
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badversion
        sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="2.2"/' \
            magpie.${submissiontype}-spark-cornercase-badversion \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-badversion \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badversion \
            magpie.${submissiontype}-spark-with-yarn-cornercase-badversion \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badversion
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badversion
        sed -i -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="2.2"/' magpie.${submissiontype}-storm-cornercase-badversion
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badversion
        sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="2.2"/' magpie.${submissiontype}-zookeeper-cornercase-badversion
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badversion
        sed -i -e 's/export ALLUXIO_VERSION="\(.*\)"/export ALLUXIO_VERSION="2.2"/' magpie.${submissiontype}-alluxio-cornercase-badversion
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badversion*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badversion-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoSetHome() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nosethome
        sed -i -e 's/export HADOOP_HOME/# export HADOOP_HOME/' magpie.${submissiontype}-hadoop-cornercase-nosethome
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nosethome
        sed -i -e 's/export PIG_HOME/# export PIG_HOME/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nosethome
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosethome
        sed -i -e 's/export HBASE_HOME/# export HBASE_HOME/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosethome
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-nosethome
        sed -i -e 's/export HIVE_HOME/# export HIVE_HOME/' magpie.${submissiontype}-hadoop-and-hive-cornercase-nosethome
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosethome
        sed -i -e 's/export PHOENIX_HOME/# export PHOENIX_HOME/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosethome
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
        sed -i -e 's/export SPARK_HOME/# export SPARK_HOME/' \
            magpie.${submissiontype}-spark-cornercase-nosethome \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-nosethome \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nosethome \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nosethome \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosethome
        sed -i -e 's/export STORM_HOME/# export STORM_HOME/' magpie.${submissiontype}-storm-cornercase-nosethome
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nosethome
        sed -i -e 's/export ZOOKEEPER_HOME/# export ZOOKEEPER_HOME/' magpie.${submissiontype}-zookeeper-cornercase-nosethome
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosethome
        sed -i -e 's/export ZEPPELIN_HOME/# export ZEPPELIN_HOME/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosethome
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-nosethome
        sed -i -e 's/export ALLUXIO_HOME/# export ALLUXIO_HOME/' magpie.${submissiontype}-alluxio-cornercase-nosethome
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosethome*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosethome-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadSetHome() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badsethome
        sed -i -e 's/export HADOOP_HOME="\(.*\)"/export HADOOP_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-badsethome
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badsethome
        sed -i -e 's/export PIG_HOME="\(.*\)"/export PIG_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsethome
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsethome
        sed -i -e 's/export HBASE_HOME="\(.*\)"/export HBASE_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsethome
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badsethome
        sed -i -e 's/export HIVE_HOME="\(.*\)"/export HIVE_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-badsethome
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsethome
        sed -i -e 's/export PHOENIX_HOME="\(.*\)"/export PHOENIX_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsethome
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
        sed -i -e 's/export SPARK_HOME="\(.*\)"/export SPARK_HOME="\/FOO\/BAR\/BAZ"/' \
            magpie.${submissiontype}-spark-cornercase-badsethome \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-badsethome \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badsethome \
            magpie.${submissiontype}-spark-with-yarn-cornercase-badsethome \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badsethome
        sed -i -e 's/export STORM_HOME="\(.*\)"/export STORM_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-storm-cornercase-badsethome
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badsethome
        sed -i -e 's/export ZOOKEEPER_HOME="\(.*\)"/export ZOOKEEPER_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-zookeeper-cornercase-badsethome
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badsethome
        sed -i -e 's/export ZEPPELIN_HOME="\(.*\)"/export ZEPPELIN_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-badsethome
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badsethome
        sed -i -e 's/export ALLUXIO_HOME="\(.*\)"/export ALLUXIO_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-alluxio-cornercase-badsethome
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badsethome*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsethome-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoSetLocalDir() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nosetlocaldir
        sed -i -e 's/export HADOOP_LOCAL_DIR/# export HADOOP_LOCAL_DIR/' magpie.${submissiontype}-hadoop-cornercase-nosetlocaldir
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetlocaldir
        sed -i -e 's/export PIG_LOCAL_DIR/# export PIG_LOCAL_DIR/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetlocaldir
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetlocaldir
        sed -i -e 's/export HBASE_LOCAL_DIR/# export HBASE_LOCAL_DIR/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetlocaldir
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetlocaldir
        sed -i -e 's/export HIVE_LOCAL_DIR/# export HIVE_LOCAL_DIR/' magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetlocaldir
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetlocaldir
        sed -i -e 's/export PHOENIX_LOCAL_DIR/# export PHOENIX_LOCAL_DIR/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetlocaldir
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetlocaldir
        sed -i -e 's/export SPARK_LOCAL_DIR/# export SPARK_LOCAL_DIR/' \
            magpie.${submissiontype}-spark-cornercase-nosetlocaldir \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-nosetlocaldir \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetlocaldir \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nosetlocaldir \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetlocaldir
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosetlocaldir
        sed -i -e 's/export STORM_LOCAL_DIR/# export STORM_LOCAL_DIR/' magpie.${submissiontype}-storm-cornercase-nosetlocaldir
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nosetlocaldir
        sed -i -e 's/export ZOOKEEPER_LOCAL_DIR/# export ZOOKEEPER_LOCAL_DIR/' magpie.${submissiontype}-zookeeper-cornercase-nosetlocaldir
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetlocaldir
        sed -i -e 's/export ZEPPELIN_LOCAL_DIR/# export ZEPPELIN_LOCAL_DIR/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetlocaldir
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-nosetlocaldir
        sed -i -e 's/export ALLUXIO_LOCAL_DIR/# export ALLUXIO_LOCAL_DIR/' magpie.${submissiontype}-alluxio-cornercase-nosetlocaldir
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosetlocaldir*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetlocaldir-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadSetLocalDir() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badlocaldir
        sed -i -e 's/export HADOOP_LOCAL_DIR="\(.*\)"/export HADOOP_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-badlocaldir
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badlocaldir
        sed -i -e 's/export PIG_LOCAL_DIR="\(.*\)"/export PIG_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badlocaldir
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badlocaldir
        sed -i -e 's/export HBASE_LOCAL_DIR="\(.*\)"/export HBASE_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badlocaldir
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badsetlocaldir
        sed -i -e 's/export HIVE_LOCAL_DIR="\(.*\)"/export HIVE_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-badsetlocaldir
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badlocaldir
        sed -i -e 's/export PHOENIX_LOCAL_DIR="\(.*\)"/export PHOENIX_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badlocaldir
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badlocaldir
        sed -i -e 's/export SPARK_LOCAL_DIR="\(.*\)"/export SPARK_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' \
            magpie.${submissiontype}-spark-cornercase-badlocaldir \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-badlocaldir \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badlocaldir \
            magpie.${submissiontype}-spark-with-yarn-cornercase-badlocaldir \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badlocaldir
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badlocaldir
        sed -i -e 's/export STORM_LOCAL_DIR="\(.*\)"/export STORM_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-storm-cornercase-badlocaldir
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badlocaldir
        sed -i -e 's/export ZOOKEEPER_LOCAL_DIR="\(.*\)"/export ZOOKEEPER_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-zookeeper-cornercase-badlocaldir
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badlocaldir
        sed -i -e 's/export ZEPPELIN_LOCAL_DIR="\(.*\)"/export ZEPPELIN_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-badlocaldir
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badlocaldir
        sed -i -e 's/export ALLUXIO_LOCAL_DIR="\(.*\)"/export ALLUXIO_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-alluxio-cornercase-badlocaldir
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badlocaldir*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badlocaldir-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoSetScript() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nosetscript
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-magpie-cornercase-nosetscript
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetscript
        sed -i -e 's/export PIG_JOB="\(.*\)"/export PIG_JOB="script"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetscript
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetscript
        sed -i -e 's/export HIVE_JOB="\(.*\)"/export HIVE_JOB="script"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-nosetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
        sed -i -e 's/export PHOENIX_JOB="\(.*\)"/export PHOENIX_JOB="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
    fi

    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-nosetscript
            sed -i -e 's/export TENSORFLOW_JOB="\(.*\)"/export TENSORFLOW_JOB="script"/' magpie.${submissiontype}-tensorflow-cornercase-nosetscript
        fi
    fi
    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-nosetscript
            sed -i -e 's/export TENSORFLOW_HOROVOD_JOB=\(.*\)/export TENSORFLOW_HOROVOD_JOB=script/' magpie.${submissiontype}-tensorflow-horovod-cornercase-nosetscript
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosetscript*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetscript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadSetScript() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-1
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-1
        sed -i -e 's/# export MAGPIE_JOB_SCRIPT="\(.*\)"/export MAGPIE_JOB_SCRIPT="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-2
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-3
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-3

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-4
        sed -i -e 's/# export MAGPIE_HOSTNAME_CMD_MAP="\(.*\)"/export MAGPIE_HOSTNAME_CMD_MAP="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-4

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-5
        sed -i -e 's/# export MAGPIE_HOSTNAME_SCHEDULER_MAP="\(.*\)"/export MAGPIE_HOSTNAME_SCHEDULER_MAP="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-5

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-6
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run.sh,\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-6

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-7
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run.sh,\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-7

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-8
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="\/FOO\/BAR\/BAZ,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run.sh"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-8

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-9
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="\/FOO\/BAR\/BAZ,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run.sh"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-9
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
        sed -i -e 's/export PIG_JOB="\(.*\)"/export PIG_JOB="script"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
        sed -i -e 's/# export PIG_SCRIPT_PATH="\(.*\)"/export PIG_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badsetscript
        sed -i -e 's/export HIVE_JOB="\(.*\)"/export HIVE_JOB="script"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-badsetscript
        sed -i -e 's/# export HIVE_SCRIPT_PATH="\(.*\)"/export HIVE_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-badsetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
        sed -i -e 's/export PHOENIX_JOB="\(.*\)"/export PHOENIX_JOB="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
        sed -i -e 's/# export PHOENIX_SCRIPT_PATH="\(.*\)"/export PHOENIX_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
    fi

    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-badsetscript
            sed -i -e 's/export TENSORFLOW_JOB="\(.*\)"/export TENSORFLOW_JOB="script"/' magpie.${submissiontype}-tensorflow-cornercase-badsetscript
            sed -i -e 's/# export TENSORFLOW_SCRIPT_PATH="\(.*\)"/export TENSORFLOW_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-tensorflow-cornercase-badsetscript
        fi
    fi
    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badsetscript
            sed -i -e 's/export TENSORFLOW_HOROVOD_JOB=\(.*\)/export TENSORFLOW_HOROVOD_JOB=script/' magpie.${submissiontype}-tensorflow-horovod-cornercase-badsetscript
            sed -i -e 's/# export TENSORFLOW_HOROVOD_SCRIPT_PATH="\(.*\)"/export TENSORFLOW_HOROVOD_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-tensorflow-horovod-cornercase-badsetscript
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badsetscript*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetscript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadHostnameMap() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-bad-hostname-map-1
        sed -i -e 's/# export MAGPIE_HOSTNAME_CMD_MAP="\(.*\)"/export MAGPIE_HOSTNAME_CMD_MAP="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hostname-map-bad.sh"/' magpie.${submissiontype}-magpie-cornercase-bad-hostname-map-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-bad-hostname-map-2
        sed -i -e 's/# export MAGPIE_HOSTNAME_SCHEDULER_MAP="\(.*\)"/export MAGPIE_HOSTNAME_SCHEDULER_MAP="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hostname-map-bad.sh"/' magpie.${submissiontype}-magpie-cornercase-bad-hostname-map-2
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-bad-hostname-map*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/bad-hostname-map-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadJobTime() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badjobtime
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badjobtime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badjobtime
    fi

    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-badjobtime
        fi
    fi

    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badjobtime
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime*"`
    if [ -n "${files}" ]
    then
        # Add in -5 minutes
        ${functiontogettimeoutput} -5
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
    fi

    # According to sbatch manpage, acceptable time formats:
    # "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".
    # Default is "minutes" in the testsuite, so we only test the other formats
    if [ "${submissiontype}" == "sbatch-srun" ]
    then
        if [ "${hadooptests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${pigtests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${hbasetests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${hivetests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${phoenixtests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${sparktests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${stormtests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${zeppelintests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${alluxiotests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime-sbatchsrun*"`
        if [ -n "${files}" ]
        then
            # Add in -5 minutes
            GetMinutesJob -5
            local minutes=${timeoutputforjob}

            GetHoursMinutesJob -5
            local hoursminutes=${timeoutputforjob}

            filesminutesseconds=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime-sbatchsrun-minutes-seconds*"`
            fileshoursminutesseconds=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime-sbatchsrun-hours-minutes-seconds*"`
            filesdayshours=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime-sbatchsrun-days-hours"`
            filesdayshoursminutes=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime-sbatchsrun-days-hours-minutes"`
            filesdayshoursminutesseconds=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds"`

            sed -i -e "s/${timestringtoreplace}/${minutes}:00/" ${filesminutesseconds}
            sed -i -e "s/${timestringtoreplace}/${hoursminutes}:00/" ${fileshoursminutesseconds}
            # Since there's no minutes field on this one, we'll just go w/ 0 hours
            sed -i -e "s/${timestringtoreplace}/0-0/" ${filesdayshours}
            sed -i -e "s/${timestringtoreplace}/0-${hoursminutes}/" ${filesdayshoursminutes}
            sed -i -e "s/${timestringtoreplace}/0-${hoursminutes}:00/" ${filesdayshoursminutesseconds}
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badjobtime*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badjobtime-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadStartupTime() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badstartuptime
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badstartuptime
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badstartuptime
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badstartuptime
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badstartuptime
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badstartuptime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badstartuptime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badstartuptime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badstartuptime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badstartuptime
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badstartuptime
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badstartuptime
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badstartuptime
    fi

    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-badstartuptime
        fi
    fi

    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badstartuptime
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badstartuptime*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_STARTUP_TIME=.*/export MAGPIE_STARTUP_TIME=1/' ${files}
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badstartuptime-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadShutdownTime() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badshutdowntime
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badshutdowntime
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badshutdowntime
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badshutdowntime
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badshutdowntime
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badshutdowntime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badshutdowntime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badshutdowntime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badshutdowntime
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badshutdowntime
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badshutdowntime
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badshutdowntime
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badshutdowntime
    fi

    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-badshutdowntime
        fi
    fi

    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badshutdowntime
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badshutdowntime*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_SHUTDOWN_TIME=.*/export MAGPIE_SHUTDOWN_TIME=1/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badshutdowntime-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadNodeCount() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badnodecount-small
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badnodecount-small
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-big
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badnodecount-big
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-big
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badnodecount-small
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badnodecount-big
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badnodecount-small
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badnodecount-small*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my_node_count>/1/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badnodecount-small-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badnodecount-big*"`
    if [ -n "${files}" ]
    then
        local badnodecountpluszookeeper=`expr ${zookeepernodecount} + 1`
        sed -i -e "s/<my_node_count>/${badnodecountpluszookeeper}/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badnodecount-big-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NoCoreSettings() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nocoresettings-1
        sed -i -e 's/export MAGPIE_SUBMISSION_TYPE/# export MAGPIE_SUBMISSION_TYPE/' magpie.${submissiontype}-magpie-cornercase-nocoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nocoresettings-2
        sed -i -e 's/export MAGPIE_JOB_TYPE/# export MAGPIE_JOB_TYPE/' magpie.${submissiontype}-magpie-cornercase-nocoresettings-2
    fi

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nocoresettings-1
        sed -i -e 's/export HADOOP_SETUP_TYPE/# export HADOOP_SETUP_TYPE/' magpie.${submissiontype}-hadoop-cornercase-nocoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nocoresettings-2
        sed -i -e 's/export HADOOP_JOB/# export HADOOP_JOB/' magpie.${submissiontype}-hadoop-cornercase-nocoresettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nocoresettings-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE/# export HADOOP_FILESYSTEM_MODE/' magpie.${submissiontype}-hadoop-cornercase-nocoresettings-3
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nocoresettings
        sed -i -e 's/export PIG_JOB/# export PIG_JOB/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nocoresettings
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
        sed -i -e 's/export HBASE_JOB/# export HBASE_JOB/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-nocoresettings
        sed -i -e 's/export HIVE_JOB/# export HIVE_JOB/' magpie.${submissiontype}-hadoop-and-hive-cornercase-nocoresettings
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
        sed -i -e 's/export PHOENIX_JOB/# export PHOENIX_JOB/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nocoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-nocoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings-1
        sed -i -e 's/export SPARK_JOB/# export SPARK_JOB/' \
            magpie.${submissiontype}-spark-cornercase-nocoresettings-1 \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-nocoresettings-1 \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings-1 \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings-1 \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nocoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-nocoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings-2
        sed -i -e 's/export SPARK_SETUP_TYPE/# export SPARK_SETUP_TYPE/' \
            magpie.${submissiontype}-spark-cornercase-nocoresettings-2 \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-nocoresettings-2 \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings-2 \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings-2 \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings-2
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nocoresettings
        sed -i -e 's/export STORM_JOB/# export STORM_JOB/' magpie.${submissiontype}-storm-cornercase-nocoresettings
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-1
        sed -i -e 's/export ZOOKEEPER_JOB/# export ZOOKEEPER_JOB/' magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-2
        sed -i -e 's/export ZOOKEEPER_REPLICATION_COUNT/# export ZOOKEEPER_REPLICATION_COUNT/' magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-3
        sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE/# export ZOOKEEPER_DATA_DIR_TYPE/' magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-3
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-nocoresettings
        sed -i -e 's/export ZEPPELIN_JOB/# export ZEPPELIN_JOB/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-nocoresettings
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-nocoresettings
        sed -i -e 's/export ALLUXIO_JOB/# export ALLUXIO_JOB/' magpie.${submissiontype}-alluxio-cornercase-nocoresettings
    fi

    if [ "${tensorflowtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow magpie.${submissiontype}-tensorflow-cornercase-nocoresettings
        sed -i -e 's/export TENSORFLOW_JOB/# export TENSORFLOW_JOB/' magpie.${submissiontype}-tensorflow-cornercase-nocoresettings
        fi
    fi

    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-nocoresettings
        sed -i -e 's/export TENSORFLOW_HOROVOD_JOB/# export TENSORFLOW_HOROVOD_JOB/' magpie.${submissiontype}-tensorflow-horovod-cornercase-nocoresettings
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nocoresettings*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nocoresettings-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadCoreSettings() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badcoresettings-1
        sed -i -e 's/export MAGPIE_SUBMISSION_TYPE="\(.*\)"/export MAGPIE_SUBMISSION_TYPE="foobar"/' magpie.${submissiontype}-magpie-cornercase-badcoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badcoresettings-2
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="foobar"/' magpie.${submissiontype}-magpie-cornercase-badcoresettings-2
    fi

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcoresettings-1
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="foobar"/' magpie.${submissiontype}-hadoop-cornercase-badcoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcoresettings-2
        sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="foobar"/' magpie.${submissiontype}-hadoop-cornercase-badcoresettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcoresettings-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="foobar"/' magpie.${submissiontype}-hadoop-cornercase-badcoresettings-3
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badcoresettings
        sed -i -e 's/export PIG_JOB="\(.*\)"/export PIG_JOB="foobar"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badcoresettings
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
        sed -i -e 's/export HBASE_JOB="\(.*\)"/export HBASE_JOB="foobar"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-badcoresettings
        sed -i -e 's/export HIVE_JOB="\(.*\)"/export HIVE_JOB="foobar"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-badcoresettings
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
        sed -i -e 's/export PHOENIX_JOB="\(.*\)"/export PHOENIX_JOB="foobar"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badcoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badcoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings-1
        sed -i -e 's/export SPARK_JOB="\(.*\)"/export SPARK_JOB="foobar"/' \
            magpie.${submissiontype}-spark-cornercase-badcoresettings-1 \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-badcoresettings-1 \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings-1 \
            magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings-1 \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badcoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-alluxio magpie.${submissiontype}-spark-with-alluxio-cornercase-badcoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings-2
        sed -i -e 's/export SPARK_SETUP_TYPE="\(.*\)"/export SPARK_SETUP_TYPE="foobar"/' \
            magpie.${submissiontype}-spark-cornercase-badcoresettings-2 \
            magpie.${submissiontype}-spark-with-alluxio-cornercase-badcoresettings-2 \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings-2 \
            magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings-2 \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings-2
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badcoresettings
        sed -i -e 's/export STORM_JOB="\(.*\)"/export STORM_JOB="foobar"/' magpie.${submissiontype}-storm-cornercase-badcoresettings
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-1
        sed -i -e 's/export ZOOKEEPER_JOB="\(.*\)"/export ZOOKEEPER_JOB="foobar"/' magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-2
        sed -i -e 's/export ZOOKEEPER_REPLICATION_COUNT=\(.*\)/export ZOOKEEPER_REPLICATION_COUNT=0/' magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-3
        sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="foobar"/' magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-3
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-badcoresettings
        sed -i -e 's/export ZEPPELIN_JOB="\(.*\)"/export ZEPPELIN_JOB="foobar"/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-badcoresettings
    fi

    if [ "${alluxiotests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-alluxio magpie.${submissiontype}-alluxio-cornercase-badcoresettings
        sed -i -e 's/export ALLUXIO_JOB="\(.*\)"/export ALLUXIO_JOB="foobar"/' magpie.${submissiontype}-alluxio-cornercase-badcoresettings
    fi

    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badcoresettings
        sed -i -e 's/export TENSORFLOW_HOROVOD_JOB/export TENSORFLOW_HOROVOD_JOB="foo"/' magpie.${submissiontype}-tensorflow-horovod-cornercase-badcoresettings
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badcoresettings*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badcoresettings-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_RequireHDFS() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1
        sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="decommissionhdfsnodes"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
        sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="upgradehdfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirehdfs-3
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-3
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-requirehdfs
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requirehdfs
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-cornercase-requirehdfs
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-and-hive-cornercase-requirehdfs
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-requirehdfs
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-requirehdfs
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs`

        sed -i \
            -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-requirehdfs*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/requirehdfs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_RequireRawnetworkfs() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-1
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="YARN"/' magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-1
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-2
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="YARN"/' magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-2
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-3
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="YARN"/' magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-3
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-1
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-2
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-3
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-requirerawnetworkfs*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/requirerawnetworkfs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_RequireYarn() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' magpie.${submissiontype}-hadoop-cornercase-requireyarn
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-requireyarn
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-1
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-1
        sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="sequential-mr"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-2
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-2
        sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="random-mr"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-2
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-requireyarn
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn

        sed -i \
            -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' \
            magpie.${submissiontype}-spark-with-yarn-cornercase-requireyarn \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-requireyarn*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/requireyarn-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadComboSettings() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcombosettings-1
        sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="decommissionhdfsnodes"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-1
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="YARN"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcombosettings-2
        sed -i -e 's/export HADOOP_JOB="\(.*\)"/export HADOOP_JOB="upgradehdfs"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-2
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="YARN"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcombosettings-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-3
        sed -i -e 's/export HADOOP_HDFS_PATH/# export HADOOP_HDFS_PATH/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-3

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcombosettings-4
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-4
        sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH/# export HADOOP_HDFSOVERLUSTRE_PATH/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-4

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcombosettings-5
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-5
        sed -i -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH/# export HADOOP_HDFSOVERNETWORKFS_PATH/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-5

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcombosettings-6
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-6
        sed -i -e 's/export HADOOP_RAWNETWORKFS_PATH/# export HADOOP_RAWNETWORKFS_PATH/' magpie.${submissiontype}-hadoop-cornercase-badcombosettings-6
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badcombosettings
        sed -i -e 's/export SPARK_LOCAL_SCRATCH_DIR/# export SPARK_LOCAL_SCRATCH_DIR/' magpie.${submissiontype}-spark-cornercase-badcombosettings
    fi

    if [ "${tensorflowhorovodtests}" == "y" ]; then
        if [ -a ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badcombosettings-cnn-no-py-file
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badcombosettings-cnn-bad-py-file
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-tensorflow-horovod magpie.${submissiontype}-tensorflow-horovod-cornercase-badcombosettings-cnn-no-params
            sed -i -e 's/export TENSORFLOW_HOROVOD_JOB=\(.*\)/export TENSORFLOW_HOROVOD_JOB=cnn-benchmark/' magpie.${submissiontype}-tensorflow-horovod-cornercase-badcombosettings-cnn*
            sed -i -e 's/#export MAGPIE_TF_CNN_BENCHMARK_PY_FILE="\(.*\)"/export MAGPIE_TF_CNN_BENCHMARK_PY_FILE="\/FOO\/BAR"/' magpie.${submissiontype}-tensorflow-horovod-cornercase-badcombosettings-cnn-bad-py-file
            sed -i -e 's/#export MAGPIE_TF_CNN_BENCHMARK_PY_FILE="\(.*\)"/export MAGPIE_TF_CNN_BENCHMARK_PY_FILE="\/bin\/bash"/' magpie.${submissiontype}-tensorflow-horovod-cornercase-badcombosettings-cnn-no-params
        fi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badcombosettings*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badcombosettings-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadDirectories() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-baddirectories-1
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-1
        sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-baddirectories-2
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-2
        sed -i -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-baddirectories-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-3
        sed -i -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-3

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-baddirectories-4
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-4
        sed -i -e 's/export HADOOP_RAWNETWORKFS_PATH="\(.*\)"/export HADOOP_RAWNETWORKFS_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-4

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-baddirectories-5
        sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-baddirectories-5
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-baddirectories
        sed -i -e 's/export SPARK_LOCAL_SCRATCH_DIR="\(.*\)"/export SPARK_LOCAL_SCRATCH_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-spark-cornercase-baddirectories
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-baddirectories
        sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-zookeeper-cornercase-baddirectories
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-baddirectories*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/baddirectories-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_NotEnoughNodesForHDFS() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-notenoughnodesforhdfs-hdfsondisk
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-notenoughnodesforhdfs-hdfsoverlustre
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-notenoughnodesforhdfs-hdfsovernetworkfs
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-notenoughnodesforhdfs-*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/<my_node_count>/3/" ${files}
        sed -i -e 's/# export HADOOP_HDFS_REPLICATION="\(.*\)"/export HADOOP_HDFS_REPLICATION="3"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/notenoughnodesforhdfs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-notenoughnodesforhdfs-hdfsondisk"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' \
            ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-notenoughnodesforhdfs-hdfsoverlustre"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
            ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-notenoughnodesforhdfs-hdfsovernetworkfs"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
            ${files}
    fi
}

__GenerateCornerCaseTests_NoLongerSupported() {
    # Way we're going to do these tests is to stuff an environment variable right before job running code
    # We set to "foobar" because the value shouldn't matter

    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nolongersupported-1
        sed -i '/# Run Job/a export MAGPIE_SCRIPT_PATH="foobar"' magpie.${submissiontype}-magpie-cornercase-nolongersupported-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nolongersupported-2
        sed -i '/# Run Job/a export MAGPIE_SCRIPT_ARGS="foobar"' magpie.${submissiontype}-magpie-cornercase-nolongersupported-2

        # We put these under "magpie tests" b/c there's no better place to put them
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nolongersupported-3
        sed -i '/# Run Job/a export KAFKA_MODE="foobar"' magpie.${submissiontype}-magpie-cornercase-nolongersupported-3

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nolongersupported-4
        sed -i '/# Run Job/a export ZEPPELIN_MODE="foobar"' magpie.${submissiontype}-magpie-cornercase-nolongersupported-4

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nolongersupported-5
        sed -i '/# Run Job/a export TACHYON_SETUP="foobar"' magpie.${submissiontype}-magpie-cornercase-nolongersupported-5
    fi

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nolongersupported-1
        sed -i '/# Run Job/a export HADOOP_MODE="foobar"' magpie.${submissiontype}-hadoop-cornercase-nolongersupported-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nolongersupported-2
        sed -i '/# Run Job/a export HADOOP_UDA_SETUP="foobar"' magpie.${submissiontype}-hadoop-cornercase-nolongersupported-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nolongersupported-3
        sed -i '/# Run Job/a export HDFS_FEDERATION_NAMENODE_COUNT="foobar"' magpie.${submissiontype}-hadoop-cornercase-nolongersupported-3

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nolongersupported-4
        sed -i '/# Run Job/a export HADOOP_PER_JOB_HDFS_PATH="foobar"' magpie.${submissiontype}-hadoop-cornercase-nolongersupported-4
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nolongersupported
        sed -i '/# Run Job/a export PIG_MODE="foobar"' magpie.${submissiontype}-hadoop-and-pig-cornercase-nolongersupported
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nolongersupported
        sed -i '/# Run Job/a export HBASE_MODE="foobar"' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nolongersupported
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadooop-and-hive-cornercase-nolongersupported
        sed -i '/# Run Job/a export HIVE_MODE="foobar"' magpie.${submissiontype}-hadoop-and-hive-cornercase-nolongersupported
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nolongersupported
        sed -i '/# Run Job/a export PHOENIX_MODE="foobar"' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nolongersupported
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nolongersupported-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nolongersupported-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nolongersupported-1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nolongersupported-1
        sed -i '/# Run Job/a export SPARK_MODE="foobar"' \
            magpie.${submissiontype}-spark-cornercase-nolongersupported-1 \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nolongersupported-1 \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nolongersupported-1 \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nolongersupported-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nolongersupported-2
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nolongersupported-2
        sed -i '/# Run Job/a export SPARK_USE_YARN="foobar"' \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nolongersupported-2 \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nolongersupported-2
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nolongersupported
        sed -i '/# Run Job/a export STORM_MODE="foobar"' magpie.${submissiontype}-storm-cornercase-nolongersupported
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nolongersupported-1
        sed -i '/# Run Job/a export ZOOKEEPER_MODE="foobar"' magpie.${submissiontype}-zookeeper-cornercase-nolongersupported-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nolongersupported-2
        sed -i '/# Run Job/a export ZOOKEEPER_PER_JOB_DATA_DIR="foobar"' magpie.${submissiontype}-zookeeper-cornercase-nolongersupported-2
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-cornercase-nolongersupported
        sed -i '/# Run Job/a export ZEPPELIN_MODE="foobar"' magpie.${submissiontype}-spark-with-zeppelin-cornercase-nolongersupported
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nolongersupported*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nolongersupported-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

GenerateCornerCaseTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Corner Case Tests"

    __GenerateCornerCaseTests_CatchProjectDependencies

    __GenerateCornerCaseTests_NoSetJava
    __GenerateCornerCaseTests_BadSetJava

    __GenerateCornerCaseTests_NoSetPython
    __GenerateCornerCaseTests_BadSetPython

    __GenerateCornerCaseTests_NoSetVersion
    __GenerateCornerCaseTests_BadVersion

    __GenerateCornerCaseTests_NoSetHome
    __GenerateCornerCaseTests_BadSetHome

    __GenerateCornerCaseTests_NoSetLocalDir
    __GenerateCornerCaseTests_BadSetLocalDir

    __GenerateCornerCaseTests_NoSetScript
    __GenerateCornerCaseTests_BadSetScript
    __GenerateCornerCaseTests_BadHostnameMap

    __GenerateCornerCaseTests_BadJobTime
    __GenerateCornerCaseTests_BadStartupTime
    __GenerateCornerCaseTests_BadShutdownTime

    __GenerateCornerCaseTests_BadNodeCount

    __GenerateCornerCaseTests_NoCoreSettings
    __GenerateCornerCaseTests_BadCoreSettings

    __GenerateCornerCaseTests_RequireHDFS
    __GenerateCornerCaseTests_RequireRawnetworkfs
    __GenerateCornerCaseTests_RequireYarn

    __GenerateCornerCaseTests_BadComboSettings

    __GenerateCornerCaseTests_BadDirectories

    __GenerateCornerCaseTests_NotEnoughNodesForHDFS

    __GenerateCornerCaseTests_NoLongerSupported
}

# GenerateCornerCasePostProcessing() {
# }
