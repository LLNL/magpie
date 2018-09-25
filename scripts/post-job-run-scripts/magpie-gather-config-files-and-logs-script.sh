#!/bin/bash

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


# export out targetdir
Gather_common () {
    local project=$1
    local saveconfdir=$2
    local savelogdir=$3
    local basedir=$4

    local NODENAME=`hostname`
    local projectuppercase=`echo ${project} | tr '[:lower:]' '[:upper:]'`
    local projectconfdir="${projectuppercase}_CONF_DIR"
    local projectlogdir="${projectuppercase}_LOG_DIR"

    if [ "${MAGPIE_HOSTNAME_CMD_MAP}X" != "X" ]
    then
        NODENAME=`${MAGPIE_HOSTNAME_CMD_MAP} $NODENAME`
        if [ $? -ne 0 ]
        then
            echo "Error in MAGPIE_HOSTNAME_CMD_MAP = ${MAGPIE_HOSTNAME_CMD_MAP}"
            exit 1
        fi
    fi

    targetdir=${basedir}/${MAGPIE_JOB_NAME}/${MAGPIE_JOB_ID}/${project}/nodes/${NODENAME}

    if [ "${saveconfdir}" == "y" ]
    then
        if [ "${!projectconfdir}X" != "X" ] && [ -d ${!projectconfdir}/ ] && [ "$(ls -A ${!projectconfdir}/)" ]
        then
            mkdir -p ${targetdir}/conf
            cp -a ${!projectconfdir}/* ${targetdir}/conf
        fi
    fi

    if [ "${savelogdir}" == "y" ]
    then
        if [ "${!projectlogdir}X" != "X" ] && [ -d ${!projectlogdir}/ ] && [ "$(ls -A ${!projectlogdir}/)" ]
        then
            mkdir -p ${targetdir}/log
            cp -a ${!projectlogdir}/* ${targetdir}/log
        fi
    fi
}

if [ -n "$1" ]
then
    basedir=$1
else
    basedir=${HOME}
fi

if [ ! -d "${basedir}" ]
then
    echo "${basedir} is not a directory"
    exit 1
fi

Gather_common "hadoop" "y" "y" ${basedir}
Gather_common "pig" "y" "n" ${basedir}
Gather_common "hbase" "y" "y" ${basedir}
Gather_common "phoenix" "y" "y" ${basedir}
Gather_common "spark" "y" "y" ${basedir}

# Special case
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

Gather_common "kafka" "y" "y" ${basedir}
Gather_common "storm" "y" "y" ${basedir}
Gather_common "zookeeper" "y" "y" ${basedir}
Gather_common "zeppelin" "y" "y" ${basedir}

exit 0
