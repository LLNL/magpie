#!/bin/sh

# This is script collects config and log files after your job is
# completed.
#
# It is a convenient script to use in the post of your job.  You can
# set it with the HADOOP_POST_JOB_RUN environment variable in
# sbatch.hadoop.
#
# By default it stores into
# $HADOOP_SCRIPTS_HOME/$SLURM_JOB_NAME/$SLURM_JOB_ID, but you may wish
# to change that.

export NODENAME=`hostname`

targetdir=${HADOOP_SCRIPTS_HOME}/${SLURM_JOB_NAME}/${SLURM_JOB_ID}/nodes/${NODENAME}
mkdir -p ${targetdir}/conf
mkdir -p ${targetdir}/log

cp -a ${HADOOP_CONF_DIR}/* ${targetdir}/conf
cp -a ${HADOOP_LOG_DIR}/* ${targetdir}/log

exit 0
