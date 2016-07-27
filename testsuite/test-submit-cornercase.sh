#!/bin/bash

source test-config.sh

__SubmitCornerCaseTests_CatchProjectDependencies() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-hbase
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-catchprojectdependency-hadoop
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-catchprojectdependency-zookeeper
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-catchprojectdependency-spark
}

__SubmitCornerCaseTests_NoSetJava() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetjava
}

__SubmitCornerCaseTests_BadSetJava() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badsetjava
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badsetjava
}

__SubmitCornerCaseTests_NoSetVersion() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nosetversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetversion
}

__SubmitCornerCaseTests_BadVersion() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badversion
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badversion

    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-4
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-5
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-6
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-7
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badversion-8
}

__SubmitCornerCaseTests_NoSetHome() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nosethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosethome
}

__SubmitCornerCaseTests_BadSetHome() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badsethome
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badsethome
}

__SubmitCornerCaseTests_NoSetLocalDir() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nosetlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-nosetlocaldir
}

__SubmitCornerCaseTests_BadSetLocalDir() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badlocaldir
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badlocaldir
}

__SubmitCornerCaseTests_NoSetScript() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nosetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nosetscript
}

__SubmitCornerCaseTests_BadSetScript() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-1
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-2
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-3
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-4
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-5
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-6
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badsetscript-7
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badsetscript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badsetscript
}

__SubmitCornerCaseTests_BadJobTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime

    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badjobtime-sbatchsrun-days-hours-minutes-seconds
}

__SubmitCornerCaseTests_BadStartupTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badstartuptime
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badstartuptime
}

__SubmitCornerCaseTests_BadShutdownTime() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badshutdowntime
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badshutdowntime
}

__SubmitCornerCaseTests_BadNodeCount() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badnodecount-big
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badnodecount-big
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badnodecount-small
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badnodecount-big
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badnodecount-small
}

__SubmitCornerCaseTests_NoCoreSettings() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nocoresettings-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nocoresettings
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-1
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-2
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nocoresettings-3
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-nocoresettings
}

__SubmitCornerCaseTests_BadCoreSettings() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcoresettings-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-badcoresettings
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-1
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-2
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-badcoresettings-3
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-cornercase-badcoresettings
}

__SubmitCornerCaseTests_RequireRawnetworkfs() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirerawnetworkfs-3
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-requirerawnetworkfs-3
}

__SubmitCornerCaseTests_RequireHDFS() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirehdfs-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirehdfs-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requirehdfs-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-requirehdfs
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requirehdfs
}

__SubmitCornerCaseTests_RequireYarn() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-1
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-requireyarn-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-requireyarn
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-requireyarn
}

__SubmitCornerCaseTests_BadComboSettings() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcombosettings-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcombosettings-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcombosettings-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcombosettings-4
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcombosettings-5
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-badcombosettings-6
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-badcombosettings
}

__SubmitCornerCaseTests_BadDirectories() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-baddirectories-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-baddirectories-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-baddirectories-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-baddirectories-4
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-baddirectories-5
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-baddirectories
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-baddirectories
}

__SubmitCornerCaseTests_NotEnoughNodesForHDFS() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-notenoughnodesforhdfs-hdfsondisk
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-notenoughnodesforhdfs-hdfsoverlustre
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-notenoughnodesforhdfs-hdfsovernetworkfs
}

__SubmitCornerCaseTests_NoLongerSupported() {
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nolongersupported-1
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nolongersupported-2
    BasicJobSubmit magpie.${submissiontype}-magpie-cornercase-nolongersupported-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nolongersupported-1
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nolongersupported-2
    BasicJobSubmit magpie.${submissiontype}-hadoop-cornercase-nolongersupported-3
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-cornercase-nolongersupported
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-cornercase-nolongersupported
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-cornercase-nolongersupported
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-cornercase-nolongersupported
    BasicJobSubmit magpie.${submissiontype}-spark-cornercase-nolongersupported-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-cornercase-nolongersupported-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nolongersupported-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nolongersupported-1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-cornercase-nolongersupported-2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-cornercase-nolongersupported-2
    BasicJobSubmit magpie.${submissiontype}-storm-cornercase-nolongersupported
    BasicJobSubmit magpie.${submissiontype}-zookeeper-cornercase-nolongersupported
}

SubmitCornerCaseTests() {
    __SubmitCornerCaseTests_CatchProjectDependencies

    # Special
    javasave=${JAVA_HOME}
    if [ "${javasave}X" != "X" ]
    then
        unset JAVA_HOME
    fi
    __SubmitCornerCaseTests_NoSetJava
    if [ "${javasave}X" != "X" ]
    then
        export JAVA_HOME="${javasave}"
    fi

    __SubmitCornerCaseTests_BadSetJava
    __SubmitCornerCaseTests_NoSetVersion
    __SubmitCornerCaseTests_BadVersion

    __SubmitCornerCaseTests_NoSetHome
    __SubmitCornerCaseTests_BadSetHome
    __SubmitCornerCaseTests_NoSetLocalDir
    __SubmitCornerCaseTests_BadSetLocalDir
    __SubmitCornerCaseTests_NoSetScript
    __SubmitCornerCaseTests_BadSetScript

    __SubmitCornerCaseTests_BadJobTime
    __SubmitCornerCaseTests_BadStartupTime
    __SubmitCornerCaseTests_BadShutdownTime

    __SubmitCornerCaseTests_BadNodeCount

    __SubmitCornerCaseTests_NoCoreSettings
    __SubmitCornerCaseTests_BadCoreSettings

    __SubmitCornerCaseTests_RequireHDFS
    __SubmitCornerCaseTests_RequireRawnetworkfs
    __SubmitCornerCaseTests_RequireYarn

    __SubmitCornerCaseTests_BadComboSettings

    __SubmitCornerCaseTests_BadDirectories

    __SubmitCornerCaseTests_NotEnoughNodesForHDFS

    __SubmitCornerCaseTests_NoLongerSupported
}
