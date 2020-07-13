#!/bin/bash

source test-common.sh
source ../magpie/lib/magpie-lib-helper

# This script will download all of the supported Apache projects for
# Magpie's testsuite, stick them in a directory based on settings
# below, and apply patches as needed.

# Note that old version packages can only be downloaded from the
# apache archive, not from Apache mirrors, so this will go to the
# archive alot, which Apache doesn't like too much.  So don't abuse
# this script too much.

# First set what packages you'd like to download.  y/n to each one

HADOOP_DOWNLOAD=n
PIG_DOWNLOAD=n
HBASE_DOWNLOAD=n
PHOENIX_DOWNLOAD=n
SPARK_DOWNLOAD=n
STORM_DOWNLOAD=n
KAFKA_DOWNLOAD=n
ZEPPELIN_DOWNLOAD=n
ZOOKEEPER_DOWNLOAD=n
ALLUXIO_DOWNLOAD=n

# Second, indicate where these will be installed into

INSTALL_PATH="$HOME/bigdata"

# And the rest of the script below will do its thing

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

APACHE_ARCHIVE_URL_BASE="https://archive.apache.org/dist/"

__download_package () {
    local package=$1
    local downloadurl=$2

    echo "Downloading from ${downloadurl}"

    PACKAGE_BASENAME=`basename ${package}`

    wget -O ${INSTALL_PATH}/${PACKAGE_BASENAME} ${downloadurl}

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

if [ "${HADOOP_DOWNLOAD}" == "y" ]
then
    for hadoopversion in ${hadoop_all_versions}
    do
        HADOOP_PACKAGE="hadoop-${hadoopversion}/hadoop-${hadoopversion}.tar.gz"
        HADOOP_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/hadoop/common/${HADOOP_PACKAGE}"

        __download_package ${HADOOP_PACKAGE} ${HADOOP_DOWNLOAD_URL}

        HADOOP_PACKAGE_BASEDIR=$(echo `basename ${HADOOP_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g')
        __apply_patches_if_exist ${HADOOP_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${HADOOP_PACKAGE_BASEDIR}-alternate-ssh.patch \
            ${MAGPIE_SCRIPTS_HOME}/patches/hadoop/${HADOOP_PACKAGE_BASEDIR}-no-local-dir.patch
    done
fi

if [ "${PIG_DOWNLOAD}" == "y" ]
then
    for pigversion in ${pig_all_versions}
    do
        PIG_PACKAGE="pig-${pigversion}/pig-${pigversion}.tar.gz"
        PIG_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/pig/${PIG_PACKAGE}"

        __download_package ${PIG_PACKAGE} ${PIG_DOWNLOAD_URL}

        # No pig patches at the moment
    done
fi

if [ "${HBASE_DOWNLOAD}" == "y" ]
then
    for hbaseversion in ${hbase_all_versions}
    do
        # Remove hyphen if necessary
        hbasetestversion=`echo ${hbaseversion} | cut -f1 -d"-"`

        # achu: Ugh, they jumped around alot with how they formatted their directory names
        # 0.98.0 - 0.98.12 - w/ hbase prefix
        # 0.98.12.1 - 0.98.24 w/o hbase prefix
        # 0.99.X - w/ hbase prefix
        # 1.0.X - w/ hbase prefix except ...
        # 1.0.1.1 - w/o hbase prefix
        # 1.1.0 - w/ hbase prefix
        # 1.1.X - w/o hbase prefix (X != 0)
        # 1.1.0.1 - w/o hbase prefix
        # 1.2.0 - present - w/o hbase prefix

        # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
        Magpie_vercomp ${hbasetestversion} "1.0.0"
        if [ $? == "2" ]
        then
            Magpie_vercomp ${hbasetestversion} "0.99.0"
            if [ $? == "2" ]
            then
                Magpie_vercomp ${hbasetestversion} "0.98.12.1"
                if [ $? == "2" ]
                then
                    HBASE_PACKAGE="hbase-${hbasetestversion}/hbase-${hbaseversion}-bin.tar.gz"
                else
                    HBASE_PACKAGE="${hbasetestversion}/hbase-${hbaseversion}-bin.tar.gz"
                fi
            else
                HBASE_PACKAGE="hbase-${hbasetestversion}/hbase-${hbaseversion}-bin.tar.gz"
            fi
        else
            Magpie_vercomp ${hbasetestversion} "1.2.0"
            if [ $? == "2" ]
            then
                Magpie_vercomp ${hbasetestversion} "1.1.0"
                if [ $? == "2" ]
                then
                    Magpie_vercomp ${hbasetestversion} "1.0.1.1"
                    if [ $? == "0" ]
                    then
                        HBASE_PACKAGE="${hbasetestversion}/hbase-${hbaseversion}-bin.tar.gz"
                    else
                        HBASE_PACKAGE="hbase-${hbaseversion}/hbase-${hbaseversion}-bin.tar.gz"
                    fi
                else
                    Magpie_vercomp ${hbasetestversion} "1.1.0"
                    if [ $? == "0" ]
                    then
                        HBASE_PACKAGE="hbase-${hbaseversion}/hbase-${hbaseversion}-bin.tar.gz"
                    else
                        HBASE_PACKAGE="${hbasetestversion}/hbase-${hbaseversion}-bin.tar.gz"
                    fi
                fi
            else
                HBASE_PACKAGE="${hbasetestversion}/hbase-${hbaseversion}-bin.tar.gz"
            fi
        fi

        HBASE_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/hbase/${HBASE_PACKAGE}"

        __download_package ${HBASE_PACKAGE} ${HBASE_DOWNLOAD_URL}

        HBASE_PACKAGE_BASEDIR=$(echo `basename ${HBASE_PACKAGE}` | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g')
        __apply_patches_if_exist ${HBASE_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${HBASE_PACKAGE_BASEDIR}-alternate-ssh.patch \
            ${MAGPIE_SCRIPTS_HOME}/patches/hbase/${HBASE_PACKAGE_BASEDIR}-no-local-dir.patch
    done
fi

if [ "${PHOENIX_DOWNLOAD}" == "y" ]
then
    for phoenixversion in ${phoenix_all_versions}
    do
        # Remove hyphen if necessary
        phoenixtestversion=`echo ${phoenixversion} | cut -f1 -d"-"`

        # achu: before 4.8.0, no 'apache' prefix

        # Returns 0 for ==, 1 for $1 > $2, 2 for $1 < $2
        Magpie_vercomp ${phoenixtestversion} "4.8.0"
        if [ $? == "2" ]
        then
            PHOENIX_PACKAGE="phoenix-${phoenixversion}/bin/phoenix-${phoenixversion}-bin.tar.gz"
        else
            PHOENIX_PACKAGE="apache-phoenix-${phoenixversion}/bin/apache-phoenix-${phoenixversion}-bin.tar.gz"
        fi

        PHOENIX_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/phoenix/${PHOENIX_PACKAGE}"

        __download_package ${PHOENIX_PACKAGE} ${PHOENIX_DOWNLOAD_URL}

        PHOENIX_PACKAGE_BASEDIR=$(echo `basename ${PHOENIX_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1/g')
        echo $PHOENIX_PACKAGE_BASEDIR
        __apply_patches_if_exist ${PHOENIX_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/phoenix/${PHOENIX_PACKAGE_BASEDIR}-java-home.patch
    done
fi

if [ "${SPARK_DOWNLOAD}" == "y" ]
then
    for sparkversion in ${spark_all_versions}
    do
        # Remove hyphen if necessary
        sparkonlyversion=`echo ${sparkversion} | cut -f1 -d"-"`
        SPARK_PACKAGE="spark-${sparkonlyversion}/spark-${sparkversion}.tgz"
        SPARK_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/spark/${SPARK_PACKAGE}"

        __download_package ${SPARK_PACKAGE} ${SPARK_DOWNLOAD_URL}

        SPARK_PACKAGE_BASEDIR=$(echo `basename ${SPARK_PACKAGE}` | sed 's/\(.*\)\.\(.*\)\.\(.*\)/\1\.\2/g')
        __apply_patches_if_exist ${SPARK_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/spark/${SPARK_PACKAGE_BASEDIR}-alternate.patch \
            ${MAGPIE_SCRIPTS_HOME}/patches/spark/${SPARK_PACKAGE_BASEDIR}-no-local-dir.patch
    done
fi

if [ "${STORM_DOWNLOAD}" == "y" ]
then
    for stormversion in ${storm_all_versions}
    do
        STORM_PACKAGE="apache-storm-${stormversion}/apache-storm-${stormversion}.tar.gz"
        STORM_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/storm/${STORM_PACKAGE}"

        __download_package ${STORM_PACKAGE} ${STORM_DOWNLOAD_URL}

        # No storm patches at the moment
    done
fi

if [ "${ZEPPELIN_DOWNLOAD}" == "y" ]
then
    for zeppelinversion in ${zeppelin_all_versions}
    do
        ZEPPELIN_PACKAGE="zeppelin-${zeppelinversion}/zeppelin-${zeppelinversion}-bin-all.tgz"
        ZEPPELIN_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/zeppelin/${ZEPPELIN_PACKAGE}"

        __download_package ${ZEPPELIN_PACKAGE} ${ZEPPELIN_DOWNLOAD_URL}

        # No zeppelin patches at the moment
    done
fi

if [ "${ZOOKEEPER_DOWNLOAD}" == "y" ]
then
    for zookeeperversion in ${zookeeper_all_versions}
    do
        ZOOKEEPER_PACKAGE="zookeeper-${zookeeperversion}/zookeeper-${zookeeperversion}.tar.gz"
        ZOOKEEPER_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/zookeeper/${ZOOKEEPER_PACKAGE}"

        __download_package ${ZOOKEEPER_PACKAGE} ${ZOOKEEPER_DOWNLOAD_URL}

        # No zookeeper patches at the moment
    done
fi

if [ "${KAFKA_DOWNLOAD}" == "y" ]
then
    for kafkaversion in ${kafka_all_versions}
    do
        kafkaonlyversion=`echo ${kafkaversion} | cut -f2 -d"-"`
        KAFKA_PACKAGE="kafka/${kafkaonlyversion}/kafka_${kafkaversion}.tgz"
        KAFKA_DOWNLOAD_URL="${APACHE_ARCHIVE_URL_BASE}/${KAFKA_PACKAGE}"

        __download_package ${KAFKA_PACKAGE} ${KAFKA_DOWNLOAD_URL}

        KAFKA_PACKAGE_BASEDIR=$(echo `basename ${KAFKA_PACKAGE}` | sed 's/\(.*\)\.\(.*\)/\1/g')
        __apply_patches_if_exist ${KAFKA_PACKAGE_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/kafka/${KAFKA_PACKAGE_BASEDIR}-no-local-dir.patch
    done

fi

if [ "${ALLUXIO_DOWNLOAD}" == "y" ]
then
    for alluxioversion in ${alluxio_all_versions}
    do
        ALLUXIO_URL="https://downloads.alluxio.io/downloads/files/${alluxioversion}/alluxio-${alluxioversion}-bin.tar.gz"
        __download_from_url "${ALLUXIO_URL}"

        ALLUXIO_BASEDIR=$(echo `basename ${ALLUXIO_URL}` | sed 's/\(.*\)-bin\.\(.*\)\.\(.*\)/\1/g')
        __apply_patches_if_exist ${ALLUXIO_BASEDIR} \
            ${MAGPIE_SCRIPTS_HOME}/patches/alluxio/${ALLUXIO_BASEDIR}.patch
    done
fi

cd ${CURRENT_DIR}
