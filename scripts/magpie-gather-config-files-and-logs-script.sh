#!/bin/sh

# This is script collects config and log files after your job is
# completed.
#
# It is a convenient script to use in the post of your job.  You can
# set it with the MAGPIE_POST_JOB_RUN environment variable in
# the main job submission file.
#
# By default it stores into
# $MAGPIE_SCRIPTS_HOME/$SLURM_JOB_NAME/$SLURM_JOB_ID, but you may wish
# to change that.

export NODENAME=`hostname`

targetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/hadoop/nodes/${NODENAME}

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

targetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/hbase/nodes/${NODENAME}

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

targetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/spark/nodes/${NODENAME}

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

targetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/storm/nodes/${NODENAME}

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

zookeepertargetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/zookeeper/nodes/${NODENAME}
        
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

exit 0
