#!/bin/sh

# This is script collects config and log files after your job is
# completed.
#
# It is a convenient script to use in the post of your job.  You can
# set it with the MAGPIE_POST_JOB_RUN environment variable in
# the main job submission file.
#
# By default it stores into
# $HOME/$MAGPIE_JOB_NAME/$MAGPIE_JOB_ID, but you may wish
# to change that.

export NODENAME=`hostname`

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/hadoop/nodes/${NODENAME}

if [ "${HADOOP_CONF_DIR}X" != "X" ] && [ -d ${HADOOP_CONF_DIR}/ ] && [ "$(ls -A ${HADOOP_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${HADOOP_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${HADOOP_LOG_DIR}X" != "X" ] && [ -d ${HADOOP_LOG_DIR}/ ] && [ "$(ls -A ${HADOOP_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${HADOOP_LOG_DIR}/* ${targetdir}/log
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/pig/nodes/${NODENAME}

if [ "${PIG_CONF_DIR}X" != "X" ] && [ -d ${PIG_CONF_DIR}/ ] && [ "$(ls -A ${PIG_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${PIG_CONF_DIR}/* ${targetdir}/conf
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/hbase/nodes/${NODENAME}

if [ "${HBASE_CONF_DIR}X" != "X" ] && [ -d ${HBASE_CONF_DIR}/ ] && [ "$(ls -A ${HBASE_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${HBASE_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${HBASE_LOG_DIR}X" != "X" ] && [ -d ${HBASE_LOG_DIR}/ ] && [ "$(ls -A ${HBASE_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${HBASE_LOG_DIR}/* ${targetdir}/log
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/phoenix/nodes/${NODENAME}

if [ "${PHOENIX_CONF_DIR}X" != "X" ] && [ -d ${PHOENIX_CONF_DIR}/ ] && [ "$(ls -A ${PHOENIX_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${PHOENIX_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${PHOENIX_LOG_DIR}X" != "X" ] && [ -d ${PHOENIX_LOG_DIR}/ ] && [ "$(ls -A ${PHOENIX_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${PHOENIX_LOG_DIR}/* ${targetdir}/log
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/spark/nodes/${NODENAME}

if [ "${SPARK_CONF_DIR}X" != "X" ] && [ -d ${SPARK_CONF_DIR}/ ] && [ "$(ls -A ${SPARK_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${SPARK_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${SPARK_LOG_DIR}X" != "X" ] && [ -d ${SPARK_LOG_DIR}/ ] && [ "$(ls -A ${SPARK_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${SPARK_LOG_DIR}/* ${targetdir}/log
fi

if [ "${SPARK_WORKER_DIRECTORY}X" != "X" ]
then
    mkdir -p ${targetdir}/work
    cd ${SPARK_WORKER_DIRECTORY}
    cp --parents `find . | grep -e 'std'` ${targetdir}/work
else
    if [ "${SPARK_LOCAL_DIR}X" != "X" ] && [ -d ${SPARK_LOCAL_DIR}/ ] && [ "$(ls -A ${SPARK_LOCAL_DIR}/)" ] \
	&& [ -d ${SPARK_LOCAL_DIR}/work ] && [ "$(ls -A ${SPARK_LOCAL_DIR}/work)" ]
    then
	mkdir -p ${targetdir}/work
	cd ${SPARK_LOCAL_DIR}/work/
	cp --parents `find . | grep -e 'std'` ${targetdir}/work
    fi
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/kafka/nodes/${NODENAME}

if [ "${KAFKA_CONF_DIR}X" != "X" ] && [ -d ${KAFKA_CONF_DIR}/ ] && [ "$(ls -A ${KAFKA_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${KAFKA_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${KAFKA_LOG_DIR}X" != "X" ] && [ -d ${KAFKA_LOG_DIR}/ ] && [ "$(ls -A ${KAFKA_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${KAFKA_LOG_DIR}/* ${targetdir}/log
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/storm/nodes/${NODENAME}

if [ "${STORM_CONF_DIR}X" != "X" ] && [ -d ${STORM_CONF_DIR}/ ] && [ "$(ls -A ${STORM_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${STORM_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${STORM_LOG_DIR}X" != "X" ] && [ -d ${STORM_LOG_DIR}/ ] && [ "$(ls -A ${STORM_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${STORM_LOG_DIR}/* ${targetdir}/log
fi

targetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/tachyon/nodes/${NODENAME}

if [ "${TACHYON_CONF_DIR}X" != "X" ] && [ -d ${TACHYON_CONF_DIR}/ ] && [ "$(ls -A ${TACHYON_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${TACHYON_CONF_DIR}/* ${targetdir}/conf
fi

if [ "${TACHYON_LOG_DIR}X" != "X" ] && [ -d ${TACHYON_LOG_DIR}/ ] && [ "$(ls -A ${TACHYON_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${TACHYON_LOG_DIR}/* ${targetdir}/log
fi

zookeepertargetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/zookeeper/nodes/${NODENAME}
        
if [ "${ZOOKEEPER_CONF_DIR}X" != "X" ] && [ -d ${ZOOKEEPER_CONF_DIR}/ ] && [ "$(ls -A ${ZOOKEEPER_CONF_DIR}/)" ]
then
    mkdir -p ${zookeepertargetdir}/conf
    cp -a ${ZOOKEEPER_CONF_DIR}/* ${zookeepertargetdir}/conf
fi

if [ "${ZOOKEEPER_LOG_DIR}X" != "X" ] && [ -d ${ZOOKEEPER_LOG_DIR}/ ] && [ "$(ls -A ${ZOOKEEPER_LOG_DIR}/)" ]
then
    mkdir -p ${zookeepertargetdir}/log
    cp -a ${ZOOKEEPER_LOG_DIR}/* ${zookeepertargetdir}/log
fi

zeppelintargetdir=${HOME}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/zeppelin/nodes/${NODENAME}
        
if [ "${ZEPPELIN_CONF_DIR}X" != "X" ] && [ -d ${ZEPPELIN_CONF_DIR}/ ] && [ "$(ls -A ${ZEPPELIN_CONF_DIR}/)" ]
then
    mkdir -p ${zeppelintargetdir}/conf
    cp -a ${ZEPPELIN_CONF_DIR}/* ${zeppelintargetdir}/conf
fi

if [ "${ZEPPELIN_LOG_DIR}X" != "X" ] && [ -d ${ZEPPELIN_LOG_DIR}/ ] && [ "$(ls -A ${ZEPPELIN_LOG_DIR}/)" ]
then
    mkdir -p ${zeppelintargetdir}/log
    cp -a ${ZEPPELIN_LOG_DIR}/* ${zeppelintargetdir}/log
fi

exit 0
