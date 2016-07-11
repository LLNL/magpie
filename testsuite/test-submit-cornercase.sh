#!/bin/bash

source test-config.sh

SubmitCornerCaseTests_CatchProjectDependencies() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hbase
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-catchprojectdependency-zookeeper
}

SubmitCornerCaseTests_NoSetJava() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosetjava
}

SubmitCornerCaseTests_BadSetJava() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badsetjava
}

SubmitCornerCaseTests_NoSetVersion() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosetversion
}

SubmitCornerCaseTests_NoSetHome() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosethome
}

SubmitCornerCaseTests_BadSetHome() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badsethome
}

SubmitCornerCaseTests_NoSetScript() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosetscript
}

SubmitCornerCaseTests_BadSetScript() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badsetscript
}

SubmitCornerCaseTests_BadJobTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime
}

SubmitCornerCaseTests_BadStartupTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badstartuptime
}

SubmitCornerCaseTests_BadShutdownTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badshutdowntime
}

SubmitCornerCaseTests_BadNodeCount() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-big
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-big
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badnodecount-big
}

SubmitCornerCaseTests_NoCoreSettings() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nocoresettings-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nocoresettings
}

SubmitCornerCaseTests_BadCoreSettings() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcoresettings-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badcoresettings
}

SubmitCornerCaseTests_RequireHDFS() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs
}

SubmitCornerCaseTests_RequireYarn() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn
}

SubmitCornerCaseTests() {
    SubmitCornerCaseTests_CatchProjectDependencies

    # Special
    javasave=${JAVA_HOME}
    if [ "${javasave}X" != "X" ]
    then
	unset JAVA_HOME
    fi
    SubmitCornerCaseTests_NoSetJava
    if [ "${javasave}X" != "X" ]
    then
	export JAVA_HOME="${javasave}"
    fi

    SubmitCornerCaseTests_BadSetJava
    SubmitCornerCaseTests_NoSetVersion
    SubmitCornerCaseTests_NoSetHome
    SubmitCornerCaseTests_BadSetHome
    SubmitCornerCaseTests_NoSetScript
    SubmitCornerCaseTests_BadSetScript

    SubmitCornerCaseTests_BadJobTime
    SubmitCornerCaseTests_BadStartupTime
    SubmitCornerCaseTests_BadShutdownTime

    SubmitCornerCaseTests_BadNodeCount

    SubmitCornerCaseTests_NoCoreSettings
    SubmitCornerCaseTests_BadCoreSettings

    SubmitCornerCaseTests_RequireHDFS
    SubmitCornerCaseTests_RequireYarn
}
