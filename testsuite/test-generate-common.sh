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

SetupMagpieTestScript () {
    local testscript=$1
    shift
    local files=$@

    sed -i \
        -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' \
        -e 's/# export MAGPIE_JOB_SCRIPT="\(.*\)"/export MAGPIE_JOB_SCRIPT="'"${magpiescriptshomesubst}"'\/testsuite\/testscripts\/'"${testscript}"'"/' \
        ${files}
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
    elif [ "${javaversion}" == "${java18}" ]
    then
        sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java18pathsubst}"'"/' ${files}
    else
        echo "Invalid Java Version Specified - ${javaversion}"
        exit 1
    fi
}

PythonCommonSubstitution() {
    local pythonversion=$1

    shift
    local files=$@

    if [ "${pythonversion}" == "${python2}" ]
    then
        sed -i -e 's/export MAGPIE_PYTHON="\(.*\)"/export MAGPIE_PYTHON="'"${magpiepython2pathsubst}"'"/' ${files}
    elif [ "${pythonversion}" == "${python3}" ]
    then
        sed -i -e 's/export MAGPIE_PYTHON="\(.*\)"/export MAGPIE_PYTHON="'"${magpiepython3pathsubst}"'"/' ${files}
    else
        echo "Invalid Python Version Specified - ${pythonversion}"
        exit 1
    fi
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
        return 1
    fi
    return 0
}

RemoveTestsCheck() {
    local project=$1
    local version=$2

    local versionunderscore=`echo ${version} | sed -e "s/\./_/g" | sed -e "s/-/_/g"`
    local projectlowercase=`echo ${project} | tr '[:upper:]' '[:lower:]'`
    local variabletocheck="${projectlowercase}_${versionunderscore}"

    if [ "${!variabletocheck}" == "n" ]
    then
        rm -f magpie.${submissiontype}*${project}-${version}-*
    fi
}
