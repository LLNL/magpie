#!/bin/sh

# This is script outputs config files.
#
# It is a convenient script to use before your job is run.  You can
# set it with the MAGPIE_PRE_JOB_RUN environment variable in
# the main job submission file.

# Run only on one node, no need to do it on all nodes
if [ "${MAGPIE_CLUSTER_NODERANK}" == "0" ]
then
    echo "**** environment variables ****"
    printenv

    echo "**** resource limits ****"
    ulimit -a

    # Cat conf files for documentation

    if [ "${HADOOP_CONF_DIR}X" != "X" ]
    then
        if [ -f "${HADOOP_CONF_DIR}/hadoop-env.sh" ]
        then
            echo "**** hadoop-env.sh ****"
            cat ${HADOOP_CONF_DIR}/hadoop-env.sh
        fi

        if [ -f "${HADOOP_CONF_DIR}/mapred-env.sh" ]
        then
            echo "**** mapred-env.sh ****"
            cat ${HADOOP_CONF_DIR}/mapred-env.sh
        fi

        if [ -f "${HADOOP_CONF_DIR}/yarn-env.sh" ]
        then
            echo "**** yarn-env.sh ****"
            cat ${HADOOP_CONF_DIR}/yarn-env.sh
        fi

        if [ -f "${HADOOP_CONF_DIR}/mapred-site.xml" ]
        then
            echo "**** mapred-site.xml ****"
            cat ${HADOOP_CONF_DIR}/mapred-site.xml
        fi

        if [ -f "${HADOOP_CONF_DIR}/core-site.xml" ]
        then
            echo "**** core-site.xml ****"
            cat ${HADOOP_CONF_DIR}/core-site.xml
        fi

        if [ -f "${HADOOP_CONF_DIR}/hdfs-site.xml" ]
        then
            echo "**** hdfs-site.xml ****"
            cat ${HADOOP_CONF_DIR}/hdfs-site.xml
        fi

        if [ -f "${HADOOP_CONF_DIR}/yarn-site.xml" ]
        then
            echo "**** yarn-site.xml ****"
            cat ${HADOOP_CONF_DIR}/yarn-site.xml
        fi
    fi

    if [ "${HBASE_CONF_DIR}X" != "X" ]
    then
        if [ -f "${HBASE_CONF_DIR}/hbase-env.sh" ]
        then
            echo "**** hbase-env.sh ****"
            cat ${HBASE_CONF_DIR}/hbase-env.sh
        fi

        if [ -f "${HBASE_CONF_DIR}/hbase-site.xml" ]
        then
            echo "**** hbase-site.xml ****"
            cat ${HBASE_CONF_DIR}/hbase-site.xml
        fi
    fi

    if [ "${SPARK_CONF_DIR}X" != "X" ]
    then
        if [ -f "${SPARK_CONF_DIR}/spark-env.sh" ]
        then
            echo "**** spark-env.sh ****"
            cat ${SPARK_CONF_DIR}/spark-env.sh
        fi

        if [ -f "${SPARK_CONF_DIR}/spark-defaults.conf" ]
        then
            echo "**** spark-defaults.conf ****"
            cat ${SPARK_CONF_DIR}/spark-defaults.conf
        fi
    fi

    if [ "${STORM_CONF_DIR}X" != "X" ]
    then
        if [ -f "${STORM_CONF_DIR}/storm-env.sh" ]
        then
            echo "**** storm-env.sh ****"
            cat ${STORM_CONF_DIR}/storm-env.sh
        fi

        if [ -f "${STORM_CONF_DIR}/storm.yaml" ]
        then
            echo "**** storm.yaml ****"
            cat ${STORM_CONF_DIR}/storm.yaml
        fi
    fi
fi

if [ "${MAGPIE_CLUSTER_NODERANK}" == "1" ]
then
    # Cat conf files for documentation

    if [ "${ZOOKEEPER_CONF_DIR}X" != "X" ]
    then
        if [ -f "${ZOOKEEPER_CONF_DIR}/zoo.cfg" ]
        then
            echo "**** zoo.cfg ****"
            cat ${ZOOKEEPER_CONF_DIR}/zoo.cfg
        fi

        if [ -f "${ZOOKEEPER_CONF_DIR}/zookeeper-env.sh" ]
        then
            echo "**** zookeeper-env.sh ****"
            cat ${ZOOKEEPER_CONF_DIR}/zookeeper-env.sh
        fi
    fi
fi

exit 0
