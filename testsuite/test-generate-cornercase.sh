#!/bin/bash

source test-generate-common.sh
source test-config.sh
source test-generate-spark-helper.sh

__GenerateCornerCaseTests_CatchProjectDependencies() {
    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hadoop-and-pig-cornercase-catchprojectdependency-hadoop
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-catchprojectdependency-hadoop
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-hadoop
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-zookeeper

        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-hadoop
        sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-zookeeper
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetjava
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetjava
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetjava
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetjava
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetjava
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetjava
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetjava
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badsetjava
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

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badsetjava*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export JAVA_HOME="\(.*\)\"/export JAVA_HOME="\/FOO\/BAR\/BAZ"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetjava-FILENAMESEARCHREPLACEKEY/" ${files}
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetversion
        sed -i -e 's/export MAHOUT_VERSION/# export MAHOUT_VERSION/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetversion
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetversion
        sed -i -e 's/export HBASE_VERSION/# export HBASE_VERSION/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetversion
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetversion
        sed -i -e 's/export PHOENIX_VERSION/# export PHOENIX_VERSION/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetversion
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosetversion
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
        sed -i -e 's/export SPARK_VERSION/# export SPARK_VERSION/' \
            magpie.${submissiontype}-spark-cornercase-nosetversion \
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

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-nosetversion*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetversion-FILENAMESEARCHREPLACEKEY/" ${files}
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosethome
        sed -i -e 's/export MAHOUT_HOME/# export MAHOUT_HOME/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosethome
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosethome
        sed -i -e 's/export HBASE_HOME/# export HBASE_HOME/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosethome
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosethome
        sed -i -e 's/export PHOENIX_HOME/# export PHOENIX_HOME/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosethome
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
        sed -i -e 's/export SPARK_HOME/# export SPARK_HOME/' \
            magpie.${submissiontype}-spark-cornercase-nosethome \
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsethome
        sed -i -e 's/export MAHOUT_HOME="\(.*\)"/export MAHOUT_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsethome
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsethome
        sed -i -e 's/export HBASE_HOME="\(.*\)"/export HBASE_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsethome
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsethome
        sed -i -e 's/export PHOENIX_HOME="\(.*\)"/export PHOENIX_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsethome
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badsethome
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
        sed -i -e 's/export SPARK_HOME="\(.*\)"/export SPARK_HOME="\/FOO\/BAR\/BAZ"/' \
            magpie.${submissiontype}-spark-cornercase-badsethome \
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetlocaldir
        sed -i -e 's/export MAHOUT_LOCAL_DIR/# export MAHOUT_LOCAL_DIR/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetlocaldir
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetlocaldir
        sed -i -e 's/export HBASE_LOCAL_DIR/# export HBASE_LOCAL_DIR/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetlocaldir
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetlocaldir
        sed -i -e 's/export PHOENIX_LOCAL_DIR/# export PHOENIX_LOCAL_DIR/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetlocaldir
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nosetlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetlocaldir
        sed -i -e 's/export SPARK_LOCAL_DIR/# export SPARK_LOCAL_DIR/' \
            magpie.${submissiontype}-spark-cornercase-nosetlocaldir \
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badlocaldir
        sed -i -e 's/export MAHOUT_LOCAL_DIR="\(.*\)"/export MAHOUT_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-badlocaldir
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badlocaldir
        sed -i -e 's/export HBASE_LOCAL_DIR="\(.*\)"/export HBASE_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badlocaldir
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badlocaldir
        sed -i -e 's/export PHOENIX_LOCAL_DIR="\(.*\)"/export PHOENIX_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badlocaldir
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badlocaldir
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badlocaldir
        sed -i -e 's/export SPARK_LOCAL_DIR="\(.*\)"/export SPARK_LOCAL_DIR="\/FOO\/BAR\/BAZ"/' \
            magpie.${submissiontype}-spark-cornercase-badlocaldir \
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

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
        sed -i -e 's/export PHOENIX_JOB="\(.*\)"/export PHOENIX_JOB="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
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
        sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\(.*\)"/export MAGPIE_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-2
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript-3
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript-3
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
        sed -i -e 's/export PIG_JOB="\(.*\)"/export PIG_JOB="script"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
        sed -i -e 's/# export PIG_SCRIPT_PATH="\(.*\)"/export PIG_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
        sed -i -e 's/export PHOENIX_JOB="\(.*\)"/export PHOENIX_JOB="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
        sed -i -e 's/# export PHOENIX_SCRIPT_PATH="\(.*\)"/export PHOENIX_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badsetscript*"`
    if [ -n "${files}" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetscript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateCornerCaseTests_BadJobTime() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badjobtime
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime
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

        if [ "${mahouttests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${hbasetests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
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
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badstartuptime
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badstartuptime
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badstartuptime
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badstartuptime
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badshutdowntime
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badshutdowntime
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badshutdowntime
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badshutdowntime
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badnodecount-small
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-big
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-big
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badnodecount-small
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
        sed -i -e "s/<my node count>/1/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badnodecount-small-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*cornercase-badnodecount-big*"`
    if [ -n "${files}" ]
    then
        local badnodecountpluszookeeper=`expr ${zookeepernodecount} + 1`
        sed -i -e "s/<my node count>/${badnodecountpluszookeeper}/" ${files}
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nocoresettings
        sed -i -e 's/export MAHOUT_JOB/# export MAHOUT_JOB/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-nocoresettings
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
        sed -i -e 's/export HBASE_JOB/# export HBASE_JOB/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
        sed -i -e 's/export PHOENIX_JOB/# export PHOENIX_JOB/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nocoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings
        sed -i -e 's/export SPARK_JOB/# export SPARK_JOB/' \
            magpie.${submissiontype}-spark-cornercase-nocoresettings \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings \
            magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings
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
        sed -i -e 's/export ZEPPELIN_MODE/# export ZEPPELIN_MODE/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-nocoresettings
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badcoresettings
        sed -i -e 's/export MAHOUT_JOB="\(.*\)"/export MAHOUT_JOB="foobar"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-badcoresettings
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
        sed -i -e 's/export HBASE_JOB="\(.*\)"/export HBASE_JOB="foobar"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
        sed -i -e 's/export PHOENIX_JOB="\(.*\)"/export PHOENIX_JOB="foobar"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badcoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings
        sed -i -e 's/export SPARK_JOB="\(.*\)"/export SPARK_JOB="foobar"/' \
            magpie.${submissiontype}-spark-cornercase-badcoresettings \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings \
            magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings
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
        sed -i -e 's/export ZEPPELIN_MODE="\(.*\)"/export ZEPPELIN_MODE="foobar"/' magpie.${submissiontype}-spark-with-zeppelin-cornercase-badcoresettings
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-requirehdfs
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-requirehdfs
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-requirehdfs
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requirehdfs
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

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-requireyarn
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
        sed -i -e "s/<my node count>/3/" ${files}
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

GenerateCornerCaseTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/
    
    echo "Making Corner Case Tests"

    __GenerateCornerCaseTests_CatchProjectDependencies

    __GenerateCornerCaseTests_NoSetJava
    __GenerateCornerCaseTests_BadSetJava

    __GenerateCornerCaseTests_NoSetVersion

    __GenerateCornerCaseTests_NoSetHome
    __GenerateCornerCaseTests_BadSetHome

    __GenerateCornerCaseTests_NoSetLocalDir
    __GenerateCornerCaseTests_BadSetLocalDir
    
    __GenerateCornerCaseTests_NoSetScript
    __GenerateCornerCaseTests_BadSetScript

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
}
