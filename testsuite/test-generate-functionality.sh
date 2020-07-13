#!/bin/bash

source test-generate-common.sh
source test-config.sh
source test-generate-spark-helper.sh

__GenerateFunctionalityTests_BadJobNames() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-job-name-dollarsign
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-job-name-dollarsign
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-job-name-dollarsign
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-job-name-dollarsign
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-job-name-dollarsign
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-job-name-dollarsign

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name-dollarsign

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-job-name-dollarsign

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name-dollarsign

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name*`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-job-name*`
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-job-name-dollarsign
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-job-name-whitespace
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-job-name-dollarsign
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-job-name*"`
    if [ -n "${files}" ]
    then
        # Some job scripts use environment variable, some use command line
        # options.  So check for quoted situation first.  If no quotes,
        # add them.
        sed -i -e 's/\"<my_job_name>\"/test job/' magpie.${submissiontype}*functionality-job-name-whitespace
        sed -i -e 's/<my_job_name>/\"test job\"/' magpie.${submissiontype}*functionality-job-name-whitespace

        sed -i -e 's/\"<my_job_name>\"/test$job/' magpie.${submissiontype}*functionality-job-name-dollarsign
        sed -i -e 's/<my_job_name>/test$job/' magpie.${submissiontype}*functionality-job-name-dollarsign
    fi
}

__GenerateFunctionalityTests_AltJobTimes() {

    # According to sbatch manpage, acceptable time formats:
    # "minutes", "minutes:seconds", "hours:minutes:seconds", "days-hours", "days-hours:minutes" and "days-hours:minutes:seconds".
    # Default is "minutes" in the testsuite, so we only test the other formats
    if [ "${submissiontype}" == "sbatch-srun" ]
    then
        if [ "${hadooptests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${pigtests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${hbasetests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${hivetests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-run-testbench-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-run-testbench-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-run-testbench-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-run-testbench-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-run-testbench-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${phoenixtests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${sparktests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-minutes-seconds

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-hours-minutes-seconds

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes

            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds

            SetupSparkWordCountHDFSCopyIn `ls \
                magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun* \
                magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun*`

            SetupSparkWordCountRawNetworkFSNoCopy `ls \
                magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altjobtime-sbatchsrun*`
        fi

        if [ "${stormtests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        if [ "${zeppelintests}" == "y" ]; then
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-hours-minutes-seconds
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-days-hours
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-days-hours-minutes
            cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds
        fi

        files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-altjobtime-sbatchsrun*"`
        if [ -n "${files}" ]
        then
            # Just go w/ 60 minutes to make it easier
            GetMinutesJob 60
            local minutes=${timeoutputforjob}

            GetHoursMinutesJob 60
            local hoursminutes=${timeoutputforjob}

            filesminutesseconds=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-altjobtime-sbatchsrun-minutes-seconds*"`
            fileshoursminutesseconds=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-altjobtime-sbatchsrun-hours-minutes-seconds*"`
            filesdayshours=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-altjobtime-sbatchsrun-days-hours"`
            filesdayshoursminutes=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-altjobtime-sbatchsrun-days-hours-minutes"`
            filesdayshoursminutesseconds=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-altjobtime-sbatchsrun-days-hours-minutes-seconds"`

            sed -i -e "s/${timestringtoreplace}/${minutes}:00/" ${filesminutesseconds}
            sed -i -e "s/${timestringtoreplace}/${hoursminutes}:00/" ${fileshoursminutesseconds}
            # Since there's no minutes field on this one, we'll just go w/ 2 hours
            sed -i -e "s/${timestringtoreplace}/0-2/" ${filesdayshours}
            sed -i -e "s/${timestringtoreplace}/0-${hoursminutes}/" ${filesdayshoursminutes}
            sed -i -e "s/${timestringtoreplace}/0-${hoursminutes}:00/" ${filesdayshoursminutesseconds}
        fi
    fi
}

__GenerateFunctionalityTests_AltConfFilesDir() {

    # Just set to the current CONF_DIR to make sure setting it works

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altconffilesdir
        sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-altconffilesdir
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altconffilesdir
        sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altconffilesdir
        sed -i -e 's/# export PIG_CONF_FILES="\(.*\)"/export PIG_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-altconffilesdir
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export HBASE_CONF_FILES="\(.*\)"/export HBASE_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-altconffilesdir
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-altconffilesdir
        sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-altconffilesdir
        sed -i -e 's/# export HIVE_CONF_FILES="\(.*\)"/export HIVE_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-altconffilesdir
        sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-altconffilesdir
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export HBASE_CONF_FILES="\(.*\)"/export HBASE_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export PHOENIX_CONF_FILES="\(.*\)"/export PHOENIX_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
        sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-altconffilesdir
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-altconffilesdir

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altconffilesdir

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altconffilesdir`

        sed -i \
            -e 's/# export SPARK_CONF_FILES="\(.*\)"/export SPARK_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' \
            magpie.${submissiontype}-spark-run-sparkpi-functionality-altconffilesdir \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altconffilesdir \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir

        sed -i \
            -e 's/# export HADOOP_CONF_FILES="\(.*\)"/export HADOOP_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-altconffilesdir \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-altconffilesdir
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-altconffilesdir
        sed -i -e 's/# export STORM_CONF_FILES="\(.*\)"/export STORM_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-storm-run-stormwordcount-functionality-altconffilesdir
        sed -i -e 's/# export ZOOKEEPER_CONF_FILES="\(.*\)"/export ZOOKEEPER_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-storm-run-stormwordcount-functionality-altconffilesdir
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altconffilesdir
        sed -i -e 's/# export SPARK_CONF_FILES="\(.*\)"/export SPARK_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altconffilesdir
        sed -i -e 's/# export ZEPPELIN_CONF_FILES="\(.*\)"/export ZEPPELIN_CONF_FILES="'"${magpiescriptshomesubst}"'\/conf\/"/' magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-altconffilesdir
    fi
}

__GenerateFunctionalityTests_TestAll() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-testall
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-hadoopterasort-run-testpig-functionality-testall
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-run-zookeeperruok-functionality-testall
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-testall
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-hbaseperformanceeval-run-phoenixperformanceeval-run-zookeeperruok-functionality-testall
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-testall

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkpi-functionality-testall

        # terasort w/ rawnetworkfs doesn't work, skip
        # cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-hadoopterasort-run-sparkpi-functionality-testall

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-hadoopterasort-run-sparkpi-functionality-testall
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-run-zookeeperruok-functionality-testall
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-sparkpi-run-checkzeppelinup-functionality-testall
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-testall*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="testall"/' ${files}

        # Guarantee 60 minutes for the job that should last awhile
        ${functiontogettimeoutput} 60
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
    fi
}

__GenerateFunctionalityTests_InteractiveMode() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-interactive-mode
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-interactive-mode
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-interactive-mode
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-interactive-mode
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-interactive-mode
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-interactive-mode
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-interactive-mode
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-interactive-mode
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-interactive-mode
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-interactive-mode
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-interactive-mode
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-interactive-mode*"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="interactive"/' \
            ${files}

        # Guarantee atleast 5 mins for the job that should end quickly
        ${functiontogettimeoutput} 5
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/interactivemode-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_Setuponlymode() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-setuponly-mode
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-setuponly-mode
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-setuponly-mode
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-setuponly-mode
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-setuponly-mode
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-setuponly-mode
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-setuponly-mode
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-setuponly-mode
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-setuponly-mode
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-setuponly-mode
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-setuponly-mode
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-setuponly-mode*"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="setuponly"/' \
            ${files}

        # Guarantee atleast 5 mins for the job that should end quickly
        ${functiontogettimeoutput} 5
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/setuponlymode-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_JobTimeout() {

    # timeoutputforjob returned
    GetSecondsJob 30

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-jobtimeout
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-jobtimeout
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-jobtimeout
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-jobtimeout
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-jobtimeout
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-jobtimeout
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-jobtimeout
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-jobtimeout
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-jobtimeout
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-jobtimeout
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-jobtimeout
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-jobtimeout*"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' \
            -e 's/# export MAGPIE_JOB_SCRIPT="\(.*\)"/export MAGPIE_JOB_SCRIPT="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-sleep.sh \-s '"${timeoutputforjob}"'"/' \
            ${files}

        # Guarantee atleast 5 mins for the job that should end quickly
        ${functiontogettimeoutput} 5
        sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/jobtimeout-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_MagpieExports() {

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-hdfs-functionality-checkexports

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-rawnetworkfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-rawnetworkfs-functionality-checkexports
        SetupRawnetworkFSStandard magpie.${submissiontype}-hadoop-rawnetworkfs-functionality-checkexports
    fi
    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-pig-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-pig-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/pig-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-pig-functionality-checkexports
    fi
    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hbase-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-functionality-checkexports
    fi
    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hive-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-hive-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-hive-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-hive-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop-and-hive-functionality-checkexports
    fi
    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/phoenix-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hbase-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-checkexports
    fi
    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-checkexports
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-checkexports
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-checkexports
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-checkexports

        sed -i -e "s/FILENAMESEARCHREPLACEKEY/spark-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-functionality-checkexports

        sed -i -e "s/FILENAMESEARCHREPLACEKEY/spark-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-hdfs-functionality-checkexports

        sed -i -e "s/FILENAMESEARCHREPLACEKEY/spark-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-yarn-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-yarn-functionality-checkexports

        sed -i -e "s/FILENAMESEARCHREPLACEKEY/spark-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hadoop-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-checkexports
    fi
    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/storm-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-storm-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-storm-functionality-checkexports
    fi
    if [ "${zookeepertests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-functionality-checkexports
        sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-zookeeper-functionality-checkexports
    fi
    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/spark-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-zeppelin-functionality-checkexports
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/zeppelin-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-spark-with-zeppelin-functionality-checkexports
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-checkexports*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ${files}
        sed -i -e 's/# export MAGPIE_JOB_SCRIPT="\(.*\)"/export MAGPIE_JOB_SCRIPT="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-env.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/checkexports-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_MagpieScript() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-magpiescript
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-magpiescript
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-magpiescript
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-magpiescript
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-magpiescript
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-magpiescript

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-magpiescript

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-magpiescript

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-magpiescript

        sed -i \
            -e 's/export SPARK_JOB="\(.*\)"/export SPARK_JOB="sparkwordcount"/' \
            magpie.${submissiontype}-spark-with-hdfs-functionality-magpiescript \
            magpie.${submissiontype}-spark-with-yarn-functionality-magpiescript \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-magpiescript

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-hdfs-functionality-magpiescript \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-magpiescript

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-hdfs-functionality-magpiescript \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-magpiescript

        sed -i \
            -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
            magpie.${submissiontype}-spark-with-yarn-functionality-magpiescript
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-magpiescript
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-magpiescript*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ${files}
        sed -i -e 's/# export MAGPIE_JOB_SCRIPT="\(.*\)"/export MAGPIE_JOB_SCRIPT="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-job-run.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/magpiescript-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_PrePostRunScripts() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostecho-multi
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostecho-multi
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostecho-multi
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-prepostecho-multi
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostecho-multi
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostecho-multi

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-multi

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho-multi

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho-multi

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts* \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostrunscripts* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostecho*`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostrunscripts* \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostecho*`
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostecho-multi
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostrunscripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostrunscripts-multi
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostecho-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostecho-multi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostrunscripts-single*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run.sh"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostrunscripts-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostrunscripts-multi*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run-multi1.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run-multi2.sh"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run-multi1.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-job-run-multi2.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostrunscripts-multi-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostecho-single*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh PREPRE"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh POSTPOST"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostecho-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostecho-multi*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh PRE1,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh PRE2"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh POST1,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh POST2"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostecho-multi-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_PreRunScriptError() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-prerunscripterror-multi2
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-prerunscripterror-multi2
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-prerunscripterror-multi2
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-prerunscripterror-multi2
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-prerunscripterror-multi2
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-prerunscripterror-multi2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror-multi2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror-multi2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror-multi2



        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-functionality-prerunscripterror* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-prerunscripterror*`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-functionality-prerunscripterror*`
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-prerunscripterror-multi2
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-prerunscripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-prerunscripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-prerunscripterror-multi2
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prerunscripterror-single*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run-error.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prerunscripterror-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prerunscripterror-multi1*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run-error.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prerunscripterror-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prerunscripterror-multi2*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_JOB_RUN="\(.*\)"/export MAGPIE_PRE_JOB_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-job-run-error.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prerunscripterror-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_PrePostExecuteScripts() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-prepostexecutescripts-multi
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-prepostexecutescripts-multi
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-prepostexecutescripts-multi
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-prepostexecutescripts-multi
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-prepostexecutescripts-multi
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-prepostexecutescripts-multi

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-multi

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-multi

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts-multi

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-prepostexecutescripts*`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-prepostexecutescripts*`
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-prepostexecutescripts-multi
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostexecutescripts-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-prepostexecutescripts-multi
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostexecutescripts-single*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run.sh"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_EXECUTE_RUN="\(.*\)"/export MAGPIE_POST_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-execute-run.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostexecutescripts-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostexecutescripts-multi*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run-multi1.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run-multi2.sh"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_EXECUTE_RUN="\(.*\)"/export MAGPIE_POST_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-execute-run-multi1.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-post-execute-run-multi2.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostexecutescripts-multi-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostecho-single*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh PREPRE"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_EXECUTE_RUN="\(.*\)"/export MAGPIE_POST_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh POSTPOST"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostecho-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-prepostecho-multi*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh PRE1,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh PRE2"/' ${files}
        sed -i -e 's/# export MAGPIE_POST_EXECUTE_RUN="\(.*\)"/export MAGPIE_POST_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh POST1,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh POST2"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/prepostecho-multi-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_PreExecuteScriptError() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-preexecutescripterror-multi2
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-functionality-preexecutescripterror-multi2
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-preexecutescripterror-multi2
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-functionality-preexecutescripterror-multi2
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-functionality-preexecutescripterror-multi2
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-preexecutescripterror-multi2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror-multi2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror-multi2

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror-multi2



        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-functionality-preexecutescripterror* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-preexecutescripterror*`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-functionality-preexecutescripterror*`
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-preexecutescripterror-multi2
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-preexecutescripterror-single
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-preexecutescripterror-multi1
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-preexecutescripterror-multi2
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-preexecutescripterror-single*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run-error.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/preexecutescripterror-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-preexecutescripterror-multi1*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run-error.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/preexecutescripterror-FILENAMESEARCHREPLACEKEY/" ${files}
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-preexecutescripterror-multi2*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_PRE_EXECUTE_RUN="\(.*\)"/export MAGPIE_PRE_EXECUTE_RUN="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run.sh,'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-pre-execute-run-error.sh"/' ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/preexecutescripterror-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_ScriptArgs() {

    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-functionality-scriptargs
    fi

    # No Pig test, "script" in Pig executes via a pig command

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-functionality-scriptargs
    fi

    # No Phoenix test, "script" in Phoenix executes via a phoenix command

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-functionality-scriptargs
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-functionality-scriptargs
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-functionality-scriptargs
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-functionality-scriptargs
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-functionality-scriptargs
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-scriptargs*"`
    if [ -n "${files}" ]
    then
        sed -i \
            -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' \
            -e 's/# export MAGPIE_JOB_SCRIPT="\(.*\)"/export MAGPIE_JOB_SCRIPT="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-echo.sh ECHOXXXECHO"/' \
            ${files}

        sed -i -e "s/FILENAMESEARCHREPLACEKEY/scriptargs-FILENAMESEARCHREPLACEKEY/" ${files}
    fi
}

__GenerateFunctionalityTests_HostnameMap() {
    if [ "${hadooptests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-functionality-hostname-map
    fi

    if [ "${pigtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-functionality-hostname-map
    fi

    if [ "${hbasetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-functionality-hostname-map
    fi

    if [ "${hivetests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-hive magpie.${submissiontype}-hadoop-and-hive-run-testbench-functionality-hostname-map
    fi

    if [ "${phoenixtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-functionality-hostname-map
    fi

    if [ "${sparktests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-functionality-hostname-map

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-hostname-map

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-hostname-map

        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-yarn-and-hdfs magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-hostname-map

        SetupSparkWordCountHDFSCopyIn `ls \
            magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-copy-in-functionality-job-name* \
            magpie.${submissiontype}-spark-with-yarn-and-hdfs-run-sparkwordcount-copy-in-functionality-job-name*`

        SetupSparkWordCountRawNetworkFSNoCopy `ls \
            magpie.${submissiontype}-spark-with-yarn-run-sparkwordcount-copy-in-functionality-job-name*`
    fi

    if [ "${stormtests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-functionality-hostname-map
    fi

    if [ "${zeppelintests}" == "y" ]; then
        cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-zeppelin magpie.${submissiontype}-spark-with-zeppelin-run-checkzeppelinup-functionality-hostname-map
    fi

    files=`find . -maxdepth 1 -name "magpie.${submissiontype}*functionality-hostname-map*"`
    if [ -n "${files}" ]
    then
        sed -i -e 's/# export MAGPIE_HOSTNAME_CMD_MAP="\(.*\)"/export MAGPIE_HOSTNAME_CMD_MAP="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hostname-map.sh"/' ${files}
        sed -i -e 's/# export MAGPIE_HOSTNAME_SCHEDULER_MAP="\(.*\)"/export MAGPIE_HOSTNAME_SCHEDULER_MAP="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/test-hostname-map.sh"/' ${files}
    fi
}

GenerateFunctionalityTests() {

    cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

    echo "Making Functionality Tests"

    __GenerateFunctionalityTests_BadJobNames

    __GenerateFunctionalityTests_AltJobTimes

    __GenerateFunctionalityTests_AltConfFilesDir

    __GenerateFunctionalityTests_TestAll

    __GenerateFunctionalityTests_InteractiveMode

    __GenerateFunctionalityTests_Setuponlymode

    __GenerateFunctionalityTests_JobTimeout

    __GenerateFunctionalityTests_MagpieExports

    __GenerateFunctionalityTests_MagpieScript

    __GenerateFunctionalityTests_PrePostRunScripts

    __GenerateFunctionalityTests_PreRunScriptError

    __GenerateFunctionalityTests_PrePostExecuteScripts

    __GenerateFunctionalityTests_PreExecuteScriptError

    __GenerateFunctionalityTests_ScriptArgs

    __GenerateFunctionalityTests_HostnameMap
}

GenerateFunctionalityPostProcessing() {
    files=`find . -maxdepth 1 -name "magpie.${submissiontype}-hadoop*functionality*"`
    if [ -n "${files}" ] && [ -x "/usr/bin/pdsh" ]
    then
        for file in ${files}
        do
            if grep HADOOP_VERSION ${file} | grep -q -E "3\.[0-9]\.[0-9]"
            then
                sed -i -e "s/FILENAMESEARCHREPLACEKEY/pdshlaunch-FILENAMESEARCHREPLACEKEY/" ${file}
            fi
        done
    fi
}
