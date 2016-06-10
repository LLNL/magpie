#!/bin/sh

JavaCommonSubstitution() {
    javaversion=$1

    shift
    files=$@

    if [ "${javaversion}" == "1.6" ]
    then
	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' ${files}
    elif [ "${javaversion}" == "1.7" ]
    then
	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' ${files}
    else
	echo "Invalid Java Version Specified - ${javaversion}"
	exit 1
    fi
}
