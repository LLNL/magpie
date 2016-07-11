#!/bin/bash

source test-generate-common.sh
source test-config.sh

GenerateCornerCaseTests_CatchProjectDependencies() {
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

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop

        sed -i \
            -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop

        sed -i \
            -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop

        sed -i -e 's/export HADOOP_SETUP=\(.*\)/export HADOOP_SETUP=no/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-catchprojectdependency-zookeeper

        sed -i -e 's/export ZOOKEEPER_SETUP=\(.*\)/export ZOOKEEPER_SETUP=no/' magpie.${submissiontype}-storm-cornercase-catchprojectdependency-zookeeper
    fi

    if ls magpie.${submissiontype}*cornercase-catchprojectdependency* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/catchprojectdependency-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-catchprojectdependency*
    fi
}

GenerateCornerCaseTests_NoSetJava() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetjava
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosetjava
    fi


    if ls magpie.${submissiontype}*cornercase-nosetjava* >& /dev/null ; then
        sed -i -e 's/export JAVA_HOME/# export JAVA_HOME/' magpie.${submissiontype}*cornercase-nosetjava*
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetjava-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-nosetjava*
    fi
}

GenerateCornerCaseTests_BadSetJava() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetjava
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badsetjava
    fi

    if ls magpie.${submissiontype}*cornercase-badsetjava* >& /dev/null ; then
        sed -i -e 's/export JAVA_HOME="\(.*\)\"/export JAVA_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}*cornercase-badsetjava*
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetjava-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badsetjava*
    fi
}
            
GenerateCornerCaseTests_NoSetVersion() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
        sed -i -e 's/export SPARK_VERSION/# export SPARK_VERSION/' \
            magpie.${submissiontype}-spark-cornercase-nosetversion \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetversion \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosetversion
        sed -i -e 's/export STORM_VERSION/# export STORM_VERSION/' magpie.${submissiontype}-storm-cornercase-nosetversion
    fi

    if ls magpie.${submissiontype}*cornercase-nosetversion* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetversion-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-nosetversion*
    fi
}

GenerateCornerCaseTests_NoSetHome() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
        sed -i -e 's/export SPARK_HOME/# export SPARK_HOME/' \
            magpie.${submissiontype}-spark-cornercase-nosethome \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nosethome \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosethome
        sed -i -e 's/export STORM_HOME/# export STORM_HOME/' magpie.${submissiontype}-storm-cornercase-nosethome
    fi

    if ls magpie.${submissiontype}*cornercase-nosethome* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosethome-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-nosethome*
    fi
}

GenerateCornerCaseTests_BadSetHome() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
        sed -i -e 's/export SPARK_HOME="\(.*\)"/export SPARK_HOME="\/FOO\/BAR\/BAZ"/' \
            magpie.${submissiontype}-spark-cornercase-badsethome \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badsethome \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badsethome
        sed -i -e 's/export STORM_HOME="\(.*\)"/export STORM_HOME="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-storm-cornercase-badsethome
    fi

    if ls magpie.${submissiontype}*cornercase-badsethome* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsethome-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badsethome*
    fi
}

GenerateCornerCaseTests_NoSetScript() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-nosetscript
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-magpie-cornercase-nosetscript
    fi

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nosetscript
        sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' magpie.${submissiontype}-hadoop-cornercase-nosetscript
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetscript
        sed -i -e 's/export PIG_MODE="\(.*\)"/export PIG_MODE="script"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetscript
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetscript
        sed -i -e 's/export MAHOUT_MODE="\(.*\)"/export MAHOUT_MODE="script"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetscript
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetscript
        sed -i -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
        sed -i -e 's/export PHOENIX_MODE="\(.*\)"/export PHOENIX_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nosetscript
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetscript
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetscript
        sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
            magpie.${submissiontype}-spark-cornercase-nosetscript \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetscript \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetscript
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nosetscript
        sed -i -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="script"/' magpie.${submissiontype}-storm-cornercase-nosetscript
    fi

    if ls magpie.${submissiontype}*cornercase-nosetscript* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nosetscript-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-nosetscript*
    fi
}

GenerateCornerCaseTests_BadSetScript() {
    if [ "${magpietests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-magpie-cornercase-badsetscript
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' magpie.${submissiontype}-magpie-cornercase-badsetscript
        sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\(.*\)"/export MAGPIE_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-magpie-cornercase-badsetscript
    fi

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badsetscript
        sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="script"/' magpie.${submissiontype}-hadoop-cornercase-badsetscript
        sed -i -e 's/# export HADOOP_SCRIPT_PATH="\(.*\)"/export HADOOP_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-cornercase-badsetscript
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
        sed -i -e 's/export PIG_MODE="\(.*\)"/export PIG_MODE="script"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
        sed -i -e 's/# export PIG_SCRIPT_PATH="\(.*\)"/export PIG_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetscript
        sed -i -e 's/export MAHOUT_MODE="\(.*\)"/export MAHOUT_MODE="script"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetscript
        sed -i -e 's/# export MAHOUT_SCRIPT_PATH="\(.*\)"/export MAHOUT_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetscript
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetscript
        sed -i -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetscript
        sed -i -e 's/# export HBASE_SCRIPT_PATH="\(.*\)"/export HBASE_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetscript
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
        sed -i -e 's/export PHOENIX_MODE="\(.*\)"/export PHOENIX_MODE="script"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
        sed -i -e 's/# export PHOENIX_SCRIPT_PATH="\(.*\)"/export PHOENIX_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badsetscript
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetscript
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetscript
        sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="script"/' \
            magpie.${submissiontype}-spark-cornercase-badsetscript \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetscript \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetscript
        sed -i -e 's/# export SPARK_SCRIPT_PATH="\(.*\)"/export SPARK_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' \
            magpie.${submissiontype}-spark-cornercase-badsetscript \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetscript \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetscript
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badsetscript
        sed -i -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="script"/' magpie.${submissiontype}-storm-cornercase-badsetscript
        sed -i -e 's/# export STORM_SCRIPT_PATH="\(.*\)"/export STORM_SCRIPT_PATH="\/FOO\/BAR\/BAZ"/' magpie.${submissiontype}-storm-cornercase-badsetscript
    fi

    if ls magpie.${submissiontype}*cornercase-badsetscript* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badsetscript-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badsetscript*
    fi
}

GenerateCornerCaseTests_BadJobTime() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badjobtime
    fi

    if ls magpie.${submissiontype}*cornercase-badjobtime* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badjobtime-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badjobtime*

        # Add in -5 minutes
        ${functiontogettimeoutput} -5
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" magpie.${submissiontype}*cornercase-badjobtime*
    fi
}

GenerateCornerCaseTests_BadStartupTime() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badstartuptime
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badstartuptime
    fi

    if ls magpie.${submissiontype}*cornercase-badstartuptime* >& /dev/null ; then
        sed -i -e 's/# export MAGPIE_STARTUP_TIME=.*/export MAGPIE_STARTUP_TIME=1/' magpie.${submissiontype}*cornercase-badstartuptime*
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' magpie.${submissiontype}*cornercase-badstartuptime*
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badstartuptime-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badstartuptime*
    fi
}

GenerateCornerCaseTests_BadShutdownTime() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badshutdowntime
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badshutdowntime
    fi

    if ls magpie.${submissiontype}*cornercase-badshutdowntime* >& /dev/null ; then
        sed -i -e 's/# export MAGPIE_SHUTDOWN_TIME=.*/export MAGPIE_SHUTDOWN_TIME=1/' magpie.${submissiontype}*cornercase-badshutdowntime*
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badshutdowntime-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badshutdowntime*
    fi
}

GenerateCornerCaseTests_BadNodeCount() {
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
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badnodecount-small
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badnodecount-small
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badnodecount-big
    fi

    if ls magpie.${submissiontype}*cornercase-badnodecount-small* >& /dev/null ; then
        sed -i -e "s/<my node count>/1/" magpie.${submissiontype}*cornercase-badnodecount-small*
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badnodecount-small-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badnodecount-small*
    fi

    if ls magpie.${submissiontype}*cornercase-badnodecount-big* >& /dev/null ; then
        local badnodecountpluszookeeper=`expr ${zookeepernodecount} + 1`
        sed -i -e "s/<my node count>/${badnodecountpluszookeeper}/" magpie.${submissiontype}*cornercase-badnodecount-big*
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badnodecount-big-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badnodecount-big*
    fi
}

GenerateCornerCaseTests_NoCoreSettings() {
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
        sed -i -e 's/export HADOOP_MODE/# export HADOOP_MODE/' magpie.${submissiontype}-hadoop-cornercase-nocoresettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-nocoresettings-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE/# export HADOOP_FILESYSTEM_MODE/' magpie.${submissiontype}-hadoop-cornercase-nocoresettings-3
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-nocoresettings
        sed -i -e 's/export PIG_MODE/# export PIG_MODE/' magpie.${submissiontype}-hadoop-and-pig-cornercase-nocoresettings
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-nocoresettings
        sed -i -e 's/export MAHOUT_MODE/# export MAHOUT_MODE/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-nocoresettings
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
        sed -i -e 's/export HBASE_MODE/# export HBASE_MODE/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
        sed -i -e 's/export PHOENIX_MODE/# export PHOENIX_MODE/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-nocoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings
        sed -i -e 's/export SPARK_MODE/# export SPARK_MODE/' \
            magpie.${submissiontype}-spark-cornercase-nocoresettings \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-nocoresettings
        sed -i -e 's/export STORM_MODE/# export STORM_MODE/' magpie.${submissiontype}-storm-cornercase-nocoresettings
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-nocoresettings
        sed -i -e 's/export ZOOKEEPER_MODE/# export ZOOKEEPER_MODE/' magpie.${submissiontype}-zookeeper-cornercase-nocoresettings
    fi

    if ls magpie.${submissiontype}*cornercase-nocoresettings* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/nocoresettings-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-nocoresettings*
    fi
}

GenerateCornerCaseTests_BadCoreSettings() {
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
        sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="foobar"/' magpie.${submissiontype}-hadoop-cornercase-badcoresettings-2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-badcoresettings-3
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="foobar"/' magpie.${submissiontype}-hadoop-cornercase-badcoresettings-3
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-badcoresettings
        sed -i -e 's/export PIG_MODE="\(.*\)"/export PIG_MODE="foobar"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-badcoresettings
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-badcoresettings
        sed -i -e 's/export MAHOUT_MODE="\(.*\)"/export MAHOUT_MODE="foobar"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-badcoresettings
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
        sed -i -e 's/export HBASE_MODE="\(.*\)"/export HBASE_MODE="foobar"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
        sed -i -e 's/export PHOENIX_MODE="\(.*\)"/export PHOENIX_MODE="foobar"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-cornercase-badcoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings
        sed -i -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="foobar"/' \
            magpie.${submissiontype}-spark-cornercase-badcoresettings \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-cornercase-badcoresettings
        sed -i -e 's/export STORM_MODE="\(.*\)"/export STORM_MODE="foobar"/' magpie.${submissiontype}-storm-cornercase-badcoresettings
    fi

    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-cornercase-badcoresettings
        sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="foobar"/' magpie.${submissiontype}-zookeeper-cornercase-badcoresettings
    fi

    if ls magpie.${submissiontype}*cornercase-badcoresettings* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/badcoresettings-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-badcoresettings*
    fi
}

GenerateCornerCaseTests_RequireHDFS() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1
        sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="decommissionhdfsnodes"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
        sed -i -e 's/export HADOOP_MODE="\(.*\)"/export HADOOP_MODE="upgradehdfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
        sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
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

        sed -i \
            -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs

        sed -i \
            -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs

        sed -i \
            -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' \
            magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs
    fi

    if ls magpie.${submissiontype}*cornercase-requirehdfs* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/requirehdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-requirehdfs*
    fi
}

GenerateCornerCaseTests_RequireYarn() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS2"/' magpie.${submissiontype}-hadoop-cornercase-requireyarn
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS2"/' magpie.${submissiontype}-hadoop-and-pig-cornercase-requireyarn
    fi

    if [ "${mahouttests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS2"/' magpie.${submissiontype}-hadoop-and-mahout-cornercase-requireyarn
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn
        sed -i -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS2"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn
        sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="sequential-mr"/' magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn

        sed -i \
            -e 's/# export SPARK_USE_YARN="\(.*\)"/export SPARK_USE_YARN=yes/' \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn

        sed -i \
            -e 's/export HADOOP_SETUP_TYPE="\(.*\)"/export HADOOP_SETUP_TYPE="HDFS2"/' \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn
    fi

    if ls magpie.${submissiontype}*cornercase-requireyarn* >& /dev/null ; then
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/requireyarn-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*cornercase-requireyarn*
    fi
}

GenerateCornerCaseTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/
    
    echo "Making Corner Case Tests"

    GenerateCornerCaseTests_CatchProjectDependencies

    GenerateCornerCaseTests_NoSetJava
    GenerateCornerCaseTests_BadSetJava

    GenerateCornerCaseTests_NoSetVersion

    GenerateCornerCaseTests_NoSetHome
    GenerateCornerCaseTests_BadSetHome
    
    GenerateCornerCaseTests_NoSetScript
    GenerateCornerCaseTests_BadSetScript

    GenerateCornerCaseTests_BadJobTime
    GenerateCornerCaseTests_BadStartupTime
    GenerateCornerCaseTests_BadShutdownTime

    GenerateCornerCaseTests_BadNodeCount

    GenerateCornerCaseTests_NoCoreSettings
    GenerateCornerCaseTests_BadCoreSettings

    GenerateCornerCaseTests_RequireHDFS
    GenerateCornerCaseTests_RequireYarn
}
