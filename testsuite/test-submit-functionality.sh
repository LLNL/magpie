#!/bin/bash

source test-config.sh

__SubmitFunctionalityTests_BadJobNames () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-job-name-dollarsign
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-job-name-whitespace
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-job-name-dollarsign
}

__SubmitFunctionalityTests_AltJobTimes () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-days-hours
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-days-hours-minutes
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
}

__SubmitFunctionalityTests_AltConfFilesDir () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-altconffilesdir
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altconffilesdir
}

__SubmitFunctionalityTests_TestAll() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-hadoopterasort-run-testpig-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-run-zookeeperruok-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-hbaseperformanceeval-run-phoenixperformanceeval-run-zookeeperruok-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkpi-functionality-testall
    # terasort w/ rawnetworkfs doesn't work, skip
    # BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-hadoopterasort-run-sparkpi-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-hadoopterasort-run-sparkpi-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-run-zookeeperruok-functionality-testall
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-sparkpi-run-checkzeppelinup-functionality-testall
}

__SubmitFunctionalityTests_InteractiveMode () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-interactive-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-interactive-mode
}

__SubmitFunctionalityTests_SetuponlyMode () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-setuponly-mode
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-setuponly-mode
}

__SubmitFunctionalityTests_JobTimeout () {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-jobtimeout
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-jobtimeout
}

__SubmitFunctionalityTests_MagpieExports() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hadoop-rawnetworkfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-zookeeper-functionality-checkexports
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-checkexports
}

__SubmitFunctionalityTests_MagpieScript() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-magpiescript
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-magpiescript
}

__SubmitFunctionalityTests_PrePostRunScripts() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostrunscripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostrunscripts-single

    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostrunscripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostrunscripts-multi

    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostecho-single

    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostecho-multi
}

__SubmitFunctionalityTests_PreRunScriptError() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-prerunscripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-prerunscripterror-single

    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-prerunscripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-prerunscripterror-multi1

    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-prerunscripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-prerunscripterror-multi2
}

__SubmitFunctionalityTests_PrePostExecuteScripts() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostexecutescripts-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostexecutescripts-single

    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostexecutescripts-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostexecutescripts-multi

    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostecho-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostecho-single

    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostecho-multi
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostecho-multi
}

__SubmitFunctionalityTests_PreExecuteScriptError() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-preexecutescripterror-single
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-preexecutescripterror-single

    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-preexecutescripterror-multi1
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-preexecutescripterror-multi1

    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-preexecutescripterror-multi2
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-preexecutescripterror-multi2
}
__SubmitFunctionalityTests_ScriptArgs() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-functionality-scriptargs
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-functionality-scriptargs
    BasicJobSubmit magpie.${submissiontype}-spark-functionality-scriptargs
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-functionality-scriptargs
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-scriptargs
    BasicJobSubmit magpie.${submissiontype}-storm-functionality-scriptargs
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-functionality-scriptargs
}

__SubmitFunctionalityTests_HostnameMap() {
    BasicJobSubmit magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-spark-run-sparkpi-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-storm-run-stormwordcount-functionality-hostname-map
    BasicJobSubmit magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-hostname-map
}

SubmitFunctionalityTests() {
    __SubmitFunctionalityTests_BadJobNames
    __SubmitFunctionalityTests_AltJobTimes
    __SubmitFunctionalityTests_AltConfFilesDir
    __SubmitFunctionalityTests_TestAll
    __SubmitFunctionalityTests_InteractiveMode
    __SubmitFunctionalityTests_SetuponlyMode
    __SubmitFunctionalityTests_JobTimeout
    __SubmitFunctionalityTests_MagpieExports
    __SubmitFunctionalityTests_MagpieScript
    __SubmitFunctionalityTests_PrePostRunScripts
    __SubmitFunctionalityTests_PreRunScriptError
    __SubmitFunctionalityTests_PrePostExecuteScripts
    __SubmitFunctionalityTests_PreExecuteScriptError
    __SubmitFunctionalityTests_ScriptArgs
    __SubmitFunctionalityTests_HostnameMap
}
