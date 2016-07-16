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
PIG_DOWNLOAD="N"
MAHOUT_DOWNLOAD="N"
ZOOKEEPER_DOWNLOAD="N"
SPARK_DOWNLOAD="N"
STORM_DOWNLOAD="N"
PHOENIX_DOWNLOAD="N"
KAFKA_DOWNLOAD="N"
ZEPPELIN_DOWNLOAD="N"

# Second, indicate some paths you'd like everything to be installed into

INSTALL_PATH="$HOME/bigdata"

# Third, indicate if you'd like Magpie to rebuild all launching
# scripts to be pre-populated with INSTALL_PATH and several other
# paths appropriately.  It's unlikely you'd ever want to say no here.
#
# Below are some additional paths that may be worth setting too.

PRESET_LAUNCH_SCRIPT_PATHS="Y"

#LOCAL_DIR_PATH="/tmp/$USER"
#HOME_DIR_PATH="$HOME"
#LUSTRE_DIR_PATH="/lustre/$USER"
#NETWORKFS_DIR_PATH="/networkfs/$USER"
#RAWNETWORKFS_DIR_PATH=/lustre/${USER}
#ZOOKEEPER_DATA_DIR_PREFIX=/lustre/${USER}
#LOCAL_DRIVE_PATH=/ssd/${USER}

# And the rest of the script below will do its thing

# User, you can change the below, but many things are hard coded based
# on the version numbers.  There are kooky inconsistencies
# between version numbers e.g. dir is hadoop2 vs hadoop2.4, is it
# tar.gz or tgz, etc.
#
# Also, patches are based on the package version number.  I may not
# have patches for every version.

HADOOP_PACKAGE="hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz"
HBASE_PACKAGE="hbase/1.2.1/hbase-1.2.1-bin.tar.gz"
PIG_PACKAGE="pig/pig-0.15.0/pig-0.15.0.tar.gz"
MAHOUT_PACKAGE="mahout/0.12.1/apache-mahout-distribution-0.12.1.tar.gz"
ZOOKEEPER_PACKAGE="zookeeper/zookeeper-3.4.8/zookeeper-3.4.8.tar.gz"
SPARK_PACKAGE="spark/spark-1.6.2/spark-1.6.2-bin-hadoop2.6.tgz"
STORM_PACKAGE="storm/apache-storm-1.0.1/apache-storm-1.0.1.tar.gz"
PHOENIX_PACKAGE="phoenix/phoenix-4.7.0-HBase-1.1/bin/phoenix-4.7.0-HBase-1.1-bin.tar.gz"
KAFKA_PACKAGE="kafka/0.9.0.0/kafka_2.11-0.9.0.0.tgz"
ZEPPELIN_PACKAGE="incubator/zeppelin/0.5.6-incubating/zeppelin-0.5.6-incubating-bin-all.tgz"

# First check some basics

if [ ! -d "${INSTALL_PATH}" ]
then
    echo "${INSTALL_PATH} not a directory"
    exit 1
fi

# Figure out where we are and where Magpie is

CURRENT_DIR=`pwd`

MAGPIE_SCRIPTS_HOME=$(cd "`dirname "$0"`"/../..; pwd)

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

if [ "${HADOOP_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_HADOOP="${APACHE_DOWNLOAD_BASE}/${HADOOP_PACKAGE}"

    HADOOP_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_HADOOP} | grep "${HADOOP_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${HADOOP_DOWNLOAD_URL}"

    HADOOP_PACKAGE_BASENAME=`basename ${HADOOP_PACKAGE}`

    wget -O ${INSTALL_PATH}/${HADOOP_PACKAGE_BASENAME} ${HADOOP_DOWNLOAD_URL}

    echo "Untarring ${HADOOP_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${HADOOP_PACKAGE_BASENAME}

    HADOOP_PACKAGE_BASEDIR=`echo $HADOOP_PACKAGE_BASENAME | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g'`
    cd ${INSTALL_PATH}/${HADOOP_PACKAGE_BASEDIR}
    echo "Applying patches"
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${HADOOP_PACKAGE_BASEDIR}-alternate-ssh.patch
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${HADOOP_PACKAGE_BASEDIR}-no-local-dir.patch
fi

if [ "${HBASE_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_HBASE="${APACHE_DOWNLOAD_BASE}/${HBASE_PACKAGE}"

    HBASE_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_HBASE} | grep "${HBASE_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${HBASE_DOWNLOAD_URL}"

    HBASE_PACKAGE_BASENAME=`basename ${HBASE_PACKAGE}`

    wget -O ${INSTALL_PATH}/${HBASE_PACKAGE_BASENAME} ${HBASE_DOWNLOAD_URL}

    echo "Untarring ${HBASE_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${HBASE_PACKAGE_BASENAME}

    HBASE_PACKAGE_BASEDIR=`echo $HBASE_PACKAGE_BASENAME | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g'`
    cd ${INSTALL_PATH}/${HBASE_PACKAGE_BASEDIR}
    echo "Applying patches"
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${HBASE_PACKAGE_BASEDIR}-alternate-ssh.patch
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${HBASE_PACKAGE_BASEDIR}-no-local-dir.patch
fi

if [ "${PIG_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_PIG="${APACHE_DOWNLOAD_BASE}/${PIG_PACKAGE}"

    PIG_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_PIG} | grep "${PIG_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${PIG_DOWNLOAD_URL}"

    PIG_PACKAGE_BASENAME=`basename ${PIG_PACKAGE}`

    wget -O ${INSTALL_PATH}/${PIG_PACKAGE_BASENAME} ${PIG_DOWNLOAD_URL}

    echo "Untarring ${PIG_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${PIG_PACKAGE_BASENAME}

    # No pig patches at the moment
fi

if [ "${MAHOUT_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_MAHOUT="${APACHE_DOWNLOAD_BASE}/${MAHOUT_PACKAGE}"

    MAHOUT_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_MAHOUT} | grep "${MAHOUT_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${MAHOUT_DOWNLOAD_URL}"

    MAHOUT_PACKAGE_BASENAME=`basename ${MAHOUT_PACKAGE}`

    wget -O ${INSTALL_PATH}/${MAHOUT_PACKAGE_BASENAME} ${MAHOUT_DOWNLOAD_URL}

    echo "Untarring ${MAHOUT_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${MAHOUT_PACKAGE_BASENAME}

    MAHOUT_PACKAGE_BASEDIR=`echo $MAHOUT_PACKAGE_BASENAME | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g'`
    cd ${INSTALL_PATH}/${MAHOUT_PACKAGE_BASEDIR}
    echo "Applying patches"
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/mahout/${MAHOUT_PACKAGE_BASEDIR}.patch
fi

if [ "${ZOOKEEPER_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_ZOOKEEPER="${APACHE_DOWNLOAD_BASE}/${ZOOKEEPER_PACKAGE}"

    ZOOKEEPER_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_ZOOKEEPER} | grep "${ZOOKEEPER_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${ZOOKEEPER_DOWNLOAD_URL}"

    ZOOKEEPER_PACKAGE_BASENAME=`basename ${ZOOKEEPER_PACKAGE}`

    wget -O ${INSTALL_PATH}/${ZOOKEEPER_PACKAGE_BASENAME} ${ZOOKEEPER_DOWNLOAD_URL}

    echo "Untarring ${ZOOKEEPER_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${ZOOKEEPER_PACKAGE_BASENAME}

    # No zookeeper patches at the moment
fi

if [ "${SPARK_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_SPARK="${APACHE_DOWNLOAD_BASE}/${SPARK_PACKAGE}"

    SPARK_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_SPARK} | grep "${SPARK_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${SPARK_DOWNLOAD_URL}"

    SPARK_PACKAGE_BASENAME=`basename ${SPARK_PACKAGE}`

    wget -O ${INSTALL_PATH}/${SPARK_PACKAGE_BASENAME} ${SPARK_DOWNLOAD_URL}

    echo "Untarring ${SPARK_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${SPARK_PACKAGE_BASENAME}

    SPARK_PACKAGE_BASEDIR=`echo $SPARK_PACKAGE_BASENAME | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1\.\2/g'`
    cd ${INSTALL_PATH}/${SPARK_PACKAGE_BASEDIR}
    echo "Applying patches"
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/spark/${SPARK_PACKAGE_BASEDIR}-alternate-all.patch
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/spark/${SPARK_PACKAGE_BASEDIR}-no-local-dir.patch
fi

if [ "${STORM_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_STORM="${APACHE_DOWNLOAD_BASE}/${STORM_PACKAGE}"

    STORM_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_STORM} | grep "${STORM_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${STORM_DOWNLOAD_URL}"

    STORM_PACKAGE_BASENAME=`basename ${STORM_PACKAGE}`

    wget -O ${INSTALL_PATH}/${STORM_PACKAGE_BASENAME} ${STORM_DOWNLOAD_URL}

    echo "Untarring ${STORM_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${STORM_PACKAGE_BASENAME}

    # No storm patches at the moment
fi

if [ "${PHOENIX_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_PHOENIX="${APACHE_DOWNLOAD_BASE}/${PHOENIX_PACKAGE}"

    PHOENIX_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_PHOENIX} | grep "${PHOENIX_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${PHOENIX_DOWNLOAD_URL}"

    PHOENIX_PACKAGE_BASENAME=`basename ${PHOENIX_PACKAGE}`

    wget -O ${INSTALL_PATH}/${PHOENIX_PACKAGE_BASENAME} ${PHOENIX_DOWNLOAD_URL}

    echo "Untarring ${PHOENIX_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${PHOENIX_PACKAGE_BASENAME}

    PHOENIX_PACKAGE_BASEDIR=`echo $PHOENIX_PACKAGE_BASENAME | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g'`
    cd ${INSTALL_PATH}/${PHOENIX_PACKAGE_BASEDIR}
    echo "Applying patches"
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/phoenix/${PHOENIX_PACKAGE_BASEDIR}-java-home.patch
fi

if [ "${KAFKA_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_KAFKA="${APACHE_DOWNLOAD_BASE}/${KAFKA_PACKAGE}"

    KAFKA_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_KAFKA} | grep "${KAFKA_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${KAFKA_DOWNLOAD_URL}"

    KAFKA_PACKAGE_BASENAME=`basename ${KAFKA_PACKAGE}`

    wget -O ${INSTALL_PATH}/${KAFKA_PACKAGE_BASENAME} ${KAFKA_DOWNLOAD_URL}

    echo "Untarring ${KAFKA_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${KAFKA_PACKAGE_BASENAME}

    KAFKA_PACKAGE_BASEDIR=`echo $KAFKA_PACKAGE_BASENAME | sed 's/\(.*\)\.\(.*\)/\1/g'`
    cd ${INSTALL_PATH}/${KAFKA_PACKAGE_BASEDIR}

    echo 'Applying patches'
    patch -p1 < ${MAGPIE_SCRIPTS_HOME}/patches/kafka/${KAFKA_PACKAGE_BASEDIR}-no-local-dir.patch

fi

if [ "${ZEPPELIN_DOWNLOAD}" == "Y" ]
then
    APACHE_DOWNLOAD_ZEPPELIN="${APACHE_DOWNLOAD_BASE}/${ZEPPELIN_PACKAGE}"

    ZEPPELIN_DOWNLOAD_URL=`wget -q -O - ${APACHE_DOWNLOAD_ZEPPELIN} | grep "${ZEPPELIN_PACKAGE}" | head -n 1 | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//'`

    echo "Downloading from ${ZEPPELIN_DOWNLOAD_URL}"

    ZEPPELIN_PACKAGE_BASENAME=`basename ${ZEPPELIN_PACKAGE}`

    wget -O ${INSTALL_PATH}/${ZEPPELIN_PACKAGE_BASENAME} ${ZEPPELIN_DOWNLOAD_URL}

    echo "Untarring ${ZEPPELIN_PACKAGE_BASENAME}"

    cd ${INSTALL_PATH}
    tar -xzf ${ZEPPELIN_PACKAGE_BASENAME}

    ZEPPELIN_PACKAGE_BASEDIR=`echo $ZEPPELIN_PACKAGE_BASENAME | sed 's/\(.*\)\.\(.*\)/\1/g'`
    cd ${INSTALL_PATH}/${ZEPPELIN_PACKAGE_BASEDIR}

    echo 'No patched needed currently.'
fi

if [ "${PRESET_LAUNCH_SCRIPT_PATHS}" == "Y" ]
then
    MAGPIE_SCRIPTS_HOME_DIRNAME=`dirname ${MAGPIE_SCRIPTS_HOME}`
    magpiescriptshomedirnamesubst=`echo ${MAGPIE_SCRIPTS_HOME_DIRNAME} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/MAGPIE_SCRIPTS_DIR_PREFIX=\(.*\)/MAGPIE_SCRIPTS_DIR_PREFIX=${magpiescriptshomedirnamesubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

    installpathsubst=`echo ${INSTALL_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/PROJECT_DIR_PREFIX=\(.*\)/PROJECT_DIR_PREFIX=${installpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

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

    if [ "${LOCAL_DRIVE_PATH}X" != "X" ]
    then
        localdrivepathsubst=`echo ${LOCAL_DRIVE_PATH} | sed "s/\\//\\\\\\\\\//g"`
        sed -i -e "s/LOCAL_DRIVE_PREFIX=\(.*\)/LOCAL_DRIVE_PREFIX=${localdrivepathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
    fi 

    cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

    echo "Making launching scripts"

    make
fi

cd ${CURRENT_DIR}
