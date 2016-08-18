#!/bin/bash

source test-common.sh
source test-config.sh
source ../magpie/lib/magpie-lib-helper

GetMinutesJob () {
    local addminutes=$1
    __minutesjob=`expr $STARTUP_TIME + $SHUTDOWN_TIME + $addminutes`
    timeoutputforjob=$__minutesjob
}

GetSecondsJob () {
    local addminutes=$1
    GetMinutesJob $addminutes
    secondsjob=`expr $__minutesjob \* 60`
    timeoutputforjob=$secondsjob
}

GetHoursMinutesJob () {
    local addminutes=$1
    GetMinutesJob $1
    local hours=`expr $__minutesjob / 60`
    local minutesleft=`expr $__minutesjob % 60`
    timeoutputforjob=`printf "%d:%02d" ${hours} ${minutesleft}`
}

JavaCommonSubstitution() {
    local javaversion=$1

    shift
    local files=$@

    if [ "${javaversion}" == "${java16}" ]
    then
        sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' ${files}
    elif [ "${javaversion}" == "${java17}" ]
    then
        sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' ${files}
    else
        echo "Invalid Java Version Specified - ${javaversion}"
        exit 1
    fi
}

SetupSparkWordCountHDFSGenericNoCopy() {
    local files=$@

    sed -i \
        -e 's/export SPARK_MODE="\(.*\)"/export SPARK_MODE="sparkwordcount"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        ${files}
}

SetupSparkWordCountHDFSGenericCopyIn() {
    local files=$@

    SetupSparkWordCountHDFSGenericNoCopy ${files}

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        ${files}
}

CheckForDependency() {
    local project=$1
    local projectcheck=$2
    local checkversion=$3

    local checkversionunderscore=`echo ${checkversion} | sed -e "s/\./_/g" -e "s/-/_/g"`
    local projectchecklowercase=`echo ${projectcheck} | tr '[:upper:]' '[:lower:]'`
    local variabletocheck="${projectchecklowercase}_${checkversionunderscore}"

    if [ "${!variabletocheck}" != "y" ]
    then
        echo "Cannot generate ${project} tests that depend on ${projectcheck} ${checkversion}, it's not enabled"
        break
    fi
}

CheckForHadoopDecomissionMinimum() {
    local testfunction=$1
    local project=$2
    local projectcheck=$3
    local projectversion=$4
    local projectminimum=$5

    if echo ${testfunction} | grep -q "requiredecommissionhdfs"
    then
        # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
        Magpie_vercomp ${projectversion} ${projectminimum}
        if [ $? == "2" ]
        then
            #echo "Cannot generate ${project} tests that depend on ${projectcheck} ${projectversion}, minimum needed for tests is ${projectminimum}"
            continue
        fi
    fi
}

RemoveTestsCheck() {
    local project=$1
    local version=$2

    local versionunderscore=`echo ${version} | sed -e "s/\./_/g" | sed -e "s/-/_/g"`
    local projectlowercase=`echo ${project} | tr '[:upper:]' '[:lower:]'`
    local variabletocheck="${projectlowercase}_${versionunderscore}"

    if [ "${!variabletocheck}" == "n" ]
    then
        rm -f magpie.${submissiontype}*${project}-${version}*
    fi
}