#!/bin/bash

# This script will download all the latest Apache projects for Magpie,
# stick them in a directory based on settings below, and apply patches
# as needed.  It's a convenient script.

# First set what packages you'd like to download.  Y or N to each one
#
# Note that
# HBase requires Zookeeper and HDFS (i.e. Hadoop).
# Pig requires Hadoop
# Storm requires Zookeeper
#
# I don't check for those in checks below b/c you could have them
# installed elsewhere.  But be aware.

HADOOP_DOWNLOAD="N"
HBASE_DOWNLOAD="N"
HIVE_DOWNLOAD="N"
PIG_DOWNLOAD="N"
ZOOKEEPER_DOWNLOAD="N"
SPARK_DOWNLOAD="N"
STORM_DOWNLOAD="N"
PHOENIX_DOWNLOAD="N"
KAFKA_DOWNLOAD="N"
ZEPPELIN_DOWNLOAD="N"
ALLUXIO_DOWNLOAD="N"

# Second, indicate some paths you'd like everything to be installed into

INSTALL_PATH="$HOME/bigdata"

# Third, indicate if you'd like Magpie to rebuild all launching
# scripts to be pre-populated with INSTALL_PATH and several other
# paths & settings appropriately.  It's unlikely you'd ever want to
# say no here.
#
# Below are some additional paths & configs that may be worth setting too.

PRESET_LAUNCH_SCRIPT_CONFIGS="N"

#JAVA_DEFAULT_PATH="/mypath/to/java"
#LOCAL_DIR_PATH="/tmp/$USER"
#HOME_DIR_PATH="$HOME"
#LUSTRE_DIR_PATH="/lustre/$USER"
#NETWORKFS_DIR_PATH="/networkfs/$USER"
#RAWNETWORKFS_DIR_PATH=/lustre/${USER}
#ZOOKEEPER_DATA_DIR_PATH=/lustre/${USER}
#LOCAL_DRIVE_PATH=/ssd/${USER}
#REMOTE_CMD=ssh

# And the rest of the script below will do its thing

# User, you can change the below, but many things are hard coded based
# on the version numbers.  There are kooky inconsistencies
# between version numbers e.g. dir is hadoop2 vs hadoop2.4, is it
# tar.gz or tgz, etc.
#
# Also, patches are based on the package version number.  I may not
# have patches for every version.

HADOOP_PACKAGE="hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz"
HBASE_PACKAGE="hbase/1.6.0/hbase-1.6.0-bin.tar.gz"
HIVE_PACKAGE="hive/2.3.0/apache-hive-2.3.0.tar.gz"
PIG_PACKAGE="pig/pig-0.17.0/pig-0.17.0.tar.gz"
ZOOKEEPER_PACKAGE="zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz"
SPARK_PACKAGE="spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz"
SPARK_HADOOP_PACKAGE="hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz"
STORM_PACKAGE="storm/apache-storm-1.2.3/apache-storm-1.2.3.tar.gz"
PHOENIX_PACKAGE="phoenix/apache-phoenix-4.14.0-HBase-1.4/bin/apache-phoenix-4.14.0-HBase-1.4-bin.tar.gz"
PHOENIX_HBASE_PACKAGE="hbase/1.4.13/hbase-1.4.13-bin.tar.gz"
KAFKA_PACKAGE="kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz"
ZEPPELIN_PACKAGE="zeppelin/zeppelin-0.8.2/zeppelin-0.8.2-bin-all.tgz"

ALLUXIO_URL="https://downloads.alluxio.io/downloads/files/2.3.0/alluxio-2.3.0-bin.tar.gz"

# First check some basics

if [ ! -d "${INSTALL_PATH}" ]
then
    echo "${INSTALL_PATH} not a directory"
    exit 1
fi

# Figure out where we are and where Magpie is

CURRENT_DIR=`pwd`

MAGPIE_SCRIPTS_HOME=$(cd "`dirname "$0"`"/..; pwd)

if [ ! -d "${MAGPIE_SCRIPTS_HOME}/patches" ]
then
    echo "${MAGPIE_SCRIPTS_HOME}/patches not a directory"
    exit 1
fi

if [ ! -d "${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates" ]
then
    echo "${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates not a directory"
    exit 1
fi

APACHE_DOWNLOAD_BASE="http://www.apache.org/dyn/closer.cgi"

__download_apache_package () {
    local package=$1

    APACHE_DOWNLOAD_PACKAGE="${APACHE_DOWNLOAD_BASE}/${package}"

    DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_PACKAGE} | grep "${package}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${DOWNLOAD_URL}"

    PACKAGE_BASENAME=`basename ${package}`

    wget -O ${INSTALL_PATH}/${PACKAGE_BASENAME} ${DOWNLOAD_URL}

    echo "Untarring ${PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${PACKAGE_BASENAME}
}

__download_from_url () {
    local url=$1

    echo "Downloading from ${url}"

    PACKAGE_BASENAME=`basename ${url}`

    wget -O ${INSTALL_PATH}/${PACKAGE_BASENAME} ${url}

    echo "Untarring ${PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${PACKAGE_BASENAME}
}

__apply_patches_if_exist () {
    local basedir=$1
    shift
    local patchfiles=$@

    cd ${INSTALL_PATH}/${basedir}

    for patchfile in ${patchfiles}
    do
        if [ -f ${patchfile} ]
        then
            patch -p1 < ${patchfile}
        fi
    done
}

if [ "${HADOOP_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${HADOOP_PACKAGE}"

    HADOOP_PACKAGE_BASEDIR=$(echo `basename ${HADOOP_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g')
    __apply_patches_if_exist ${HADOOP_PACKAGE_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${HADOOP_PACKAGE_BASEDIR}-alternate-ssh.patch \
        ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${HADOOP_PACKAGE_BASEDIR}-no-local-dir.patch
fi

if [ "${HBASE_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${HBASE_PACKAGE}"

    HBASE_PACKAGE_BASEDIR=$(echo `basename ${HBASE_PACKAGE}` | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g')
    __apply_patches_if_exist ${HBASE_PACKAGE_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${HBASE_PACKAGE_BASEDIR}-alternate-ssh.patch \
        ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${HBASE_PACKAGE_BASEDIR}-no-local-dir.patch
fi

if [ "${HIVE_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${HIVE_PACKAGE}"

    HIVE_PACKAGE_BASEDIR=$(echo `basename ${HIVE_PACKAGE}` | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g')
    __apply_patches_if_exist ${HIVE_PACKAGE_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/hive/${HIVE_PACKAGE_BASEDIR}-alternate-ssh.patch \
        ${MAGPIE_SCRIPTS_HOME}/patches/hive/${HIVE_PACKAGE_BASEDIR}-no-local-dir.patch
fi

if [ "${PIG_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${PIG_PACKAGE}"

    # No pig patches at the moment
fi

if [ "${ZOOKEEPER_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${ZOOKEEPER_PACKAGE}"

    # No zookeeper patches at the moment
fi

if [ "${SPARK_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${SPARK_PACKAGE}"

    SPARK_PACKAGE_BASEDIR=$(echo `basename ${SPARK_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1\.\2/g')
    __apply_patches_if_exist ${SPARK_PACKAGE_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/spark/${SPARK_PACKAGE_BASEDIR}-alternate.patch \
        ${MAGPIE_SCRIPTS_HOME}/patches/spark/${SPARK_PACKAGE_BASEDIR}-no-local-dir.patch

    if [ "${HADOOP_DOWNLOAD}" == "N" ] || [ "${HADOOP_PACKAGE}" != "${SPARK_HADOOP_PACKAGE}" ]
    then
        __download_apache_package "${SPARK_HADOOP_PACKAGE}"

        SPARK_HADOOP_PACKAGE_BASEDIR=$(echo `basename ${SPARK_HADOOP_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g')
        __apply_patches_if_exist ${SPARK_HADOOP_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${SPARK_HADOOP_PACKAGE_BASEDIR}-alternate-ssh.patch \
            ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${SPARK_HADOOP_PACKAGE_BASEDIR}-no-local-dir.patch
    fi
fi

if [ "${STORM_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${STORM_PACKAGE}"

    # No storm patches at the moment
fi

if [ "${PHOENIX_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${PHOENIX_PACKAGE}"

    PHOENIX_PACKAGE_BASEDIR=$(echo `basename ${PHOENIX_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g')
    __apply_patches_if_exist ${PHOENIX_PACKAGE_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/phoenix/${PHOENIX_PACKAGE_BASEDIR}-java-home.patch

    if [ "${HBASE_PACKAGE}" != "${PHOENIX_HBASE_PACKAGE}" ]
    then
        __download_apache_package "${PHOENIX_HBASE_PACKAGE}"

        PHOENIX_HBASE_PACKAGE_BASEDIR=$(echo `basename ${PHOENIX_HBASE_PACKAGE}` | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g')
        __apply_patches_if_exist ${PHOENIX_HBASE_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${PHOENIX_HBASE_PACKAGE_BASEDIR}-alternate-ssh.patch \
            ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${PHOENIX_HBASE_PACKAGE_BASEDIR}-no-local-dir.patch
    fi
fi

if [ "${KAFKA_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${KAFKA_PACKAGE}"

    KAFKA_PACKAGE_BASEDIR=$(echo `basename ${KAFKA_PACKAGE}` | sed 's/\(.*\)\.\(.*\)/\1/g')
    __apply_patches_if_exist ${KAFKA_PACKAGE_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/kafka/${KAFKA_PACKAGE_BASEDIR}-no-local-dir.patch

fi

if [ "${ZEPPELIN_DOWNLOAD}" == "Y" ]
then
    __download_apache_package "${ZEPPELIN_PACKAGE}"

    # No zeppelin patches at the moment
fi

if [ "${ALLUXIO_DOWNLOAD}" == "Y" ]
then
    __download_from_url "${ALLUXIO_URL}"

    ALLUXIO_BASEDIR=$(echo `basename ${ALLUXIO_URL}` | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g')
    __apply_patches_if_exist ${ALLUXIO_BASEDIR} \
        ${MAGPIE_SCRIPTS_HOME}/patches/alluxio/${ALLUXIO_BASEDIR}.patch
fi

if [ "${PRESET_LAUNCH_SCRIPT_CONFIGS}" == "Y" ]
then
    MAGPIE_SCRIPTS_HOME_DIRNAME=`dirname ${MAGPIE_SCRIPTS_HOME}`
    magpiescriptshomedirnamesubst=`echo ${MAGPIE_SCRIPTS_HOME_DIRNAME} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/MAGPIE_SCRIPTS_DIR_PREFIX=\(.*\)/MAGPIE_SCRIPTS_DIR_PREFIX=${magpiescriptshomedirnamesubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

    installpathsubst=`echo ${INSTALL_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/PROJECT_DIR_PREFIX=\(.*\)/PROJECT_DIR_PREFIX=${installpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

    if [ "${JAVA_DEFAULT_PATH}X" != "X" ]
    then
        javadefaultpathsubst=`echo ${JAVA_DEFAULT_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/JAVA_DEFAULT=\(.*\)/JAVA_DEFAULT=${javadefaultpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${LOCAL_DIR_PATH}X" != "X" ]
    then
        localdirpathsubst=`echo ${LOCAL_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/LOCAL_DIR_PREFIX=\(.*\)/LOCAL_DIR_PREFIX=${localdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${HOME_DIR_PATH}X" != "X" ]
    then
        homedirpathsubst=`echo ${HOME_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/HOME_DIR_PREFIX=\(.*\)/HOME_DIR_PREFIX=${homedirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${LUSTRE_DIR_PATH}X" != "X" ]
    then
        lustredirpathsubst=`echo ${LUSTRE_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/LUSTRE_DIR_PREFIX=\(.*\)/LUSTRE_DIR_PREFIX=${lustredirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${NETWORKFS_DIR_PATH}X" != "X" ]
    then
        networkfsdirpathsubst=`echo ${NETWORKFS_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/NETWORKFS_DIR_PREFIX=\(.*\)/NETWORKFS_DIR_PREFIX=${networkfsdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${RAWNETWORKFS_DIR_PATH}X" != "X" ]
    then
        rawnetworkfsdirpathsubst=`echo ${RAWNETWORKFS_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/RAWNETWORKFS_DIR_PREFIX=\(.*\)/RAWNETWORKFS_DIR_PREFIX=${rawnetworkfsdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${ZOOKEEPER_DATA_DIR_PATH}X" != "X" ]
    then
        localdrivepathsubst=`echo ${ZOOKEEPER_DATA_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/ZOOKEEPER_DATA_DIR_PREFIX=\(.*\)/ZOOKEEPER_DATA_DIR_PREFIX=${localdrivepathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${LOCAL_DRIVE_PATH}X" != "X" ]
    then
        localdrivepathsubst=`echo ${LOCAL_DRIVE_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/LOCAL_DRIVE_PREFIX=\(.*\)/LOCAL_DRIVE_PREFIX=${localdrivepathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    if [ "${REMOTE_CMD}X" != "X" ]
    then
        remotecmdsubst=`echo ${REMOTE_CMD} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/REMOTE_CMD_DEFAULT=\(.*\)/REMOTE_CMD_DEFAULT=${remotecmdsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi

    cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

    echo "Making launching scripts"

    make
fi

cd ${CURRENT_DIR}
