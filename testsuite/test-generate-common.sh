#!/bin/bash

source test-common.sh
source test-config.sh

GetMinutesJob () {
    local addminutes=$1
    minutesjob=`expr $STARTUP_TIME + $SHUTDOWN_TIME + $addminutes`
    timeoutputforjob=$minutesjob
}

GetSecondsJob () {
    local addminutes=$1
    GetMinutesJob $addminutes
    secondsjob=`expr $minutesjob \* 60`
    timeoutputforjob=$secondsjob
}

GetHoursMinutesJob () {
    local addminutes=$1
    GetMinutesJob $1
    local hours=`expr $minutesjob / 60`
    local minutesleft=`expr $minutesjob % 60`
    timeoutputforjob=$(printf "%d:%02d" ${hours} ${minutesleft})
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

CheckForDependency() {
    local project=$1
    local projectcheck=$2
    local checkversion=$3

    local checkversionunderscore=`echo ${checkversion} | sed -e "s/\./_/g"`
    local projectchecklowercase=`echo ${projectcheck} | tr '[:upper:]' '[:lower:]'`
    local variabletocheck="${projectchecklowercase}_${checkversionunderscore}"

    if [ "${!variabletocheck}" != "y" ]
    then
	echo "Cannot generate ${project} tests that depend on ${projectcheck} ${checkversion}, it's not enabled"
	break
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