#!/bin/sh

# This is script collects config and log files after your job is
# completed.
#
# It is a convenient script to use in the post of your job.  You can
# set it with the MAGPIE_POST_JOB_RUN environment variable in
# magpie.sbatch.
#
# By default it stores into
# $MAGPIE_SCRIPTS_HOME/$SLURM_JOB_NAME/$SLURM_JOB_ID, but you may wish
# to change that.

export NODENAME=`hostname`

targetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/hadoop/nodes/${NODENAME}

if [ -d ${HADOOP_CONF_DIR}/ ] && [ "$(ls -A ${HADOOP_CONF_DIR}/)" ]
then
    mkdir -p ${targetdir}/conf
    cp -a ${HADOOP_CONF_DIR}/* ${targetdir}/conf
fi

if [ -d ${HADOOP_LOG_DIR}/ ] && [ "$(ls -A ${HADOOP_LOG_DIR}/)" ]
then
    mkdir -p ${targetdir}/log
    cp -a ${HADOOP_LOG_DIR}/* ${targetdir}/log
fi

zookeepertargetdir=${MAGPIE_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/zookeeper/nodes/${NODENAME}
        
if [ -d ${ZOOKEEPER_CONF_DIR}/ ] && [ "$(ls -A ${ZOOKEEPER_CONF_DIR}/)" ]
then
    mkdir -p ${zookeepertargetdir}/conf
    cp -a ${ZOOKEEPER_CONF_DIR}/* ${zookeepertargetdir}/conf
fi

if [ -d ${ZOOKEEPER_LOG_DIR}/ ] && [ "$(ls -A ${ZOOKEEPER_LOG_DIR}/)" ]
then
    mkdir -p ${zookeepertargetdir}/log
    cp -a ${ZOOKEEPER_LOG_DIR}/* ${zookeepertargetdir}/log
fi

exit 0
