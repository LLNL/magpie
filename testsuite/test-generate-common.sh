#!/bin/bash

source test-common.sh

JavaCommonSubstitution() {
    javaversion=$1

    shift
    files=$@

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
