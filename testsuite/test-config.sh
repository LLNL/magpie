#!/bin/bash

# Job Submission Config

# Note msub-torque-pdsh not done yet

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh
submissiontype=sbatch-srun

msubslurmsrunpartition=mycluster
msubslurmsrunbatchqueue=pbatch

sbatchsrunpartition=pbatch

lsfqueue=standard

# Test config
#
# base node counts for job submission
#
# base node count of 8 means most jobs will be job size of 9, the
# additional 1 will be added later for the master.
#
# zookeepernodecount will be added when necessary
#
# optional tweaks to test defaults to make some run faster
basenodecount=4
zookeepernodecount=3
hadoopterasortsize=10000000
hbaseperformanceevalrowcount=50000
phoenixperformanceevalrowcount=10000

# Configure Makefile

# Remember to escape $ w/ \ if you want the environment variables
# placed into the submission scripts instead of being expanded out

DEFAULT_HADOOP_FILESYSTEM_MODE="hdfsoverlustre"

LOCAL_DIR_PATH="/tmp/\${USER}"
HOME_DIR_PATH="\${HOME}"
LUSTRE_DIR_PATH="/p/lcratery/\${USER}/testing"
NETWORKFS_DIR_PATH="/p/lcratery/\${USER}/testing"
RAWNETWORKFS_DIR_PATH="/p/lcratery/\${USER}/testing"
ZOOKEEPER_DATA_DIR_PATH="/p/lcratery/\${USER}/testing"
SSD_DIR_PATH="/ssd/tmp1/\${USER}"

# Set just PROJECT_DIR_PATH is it's the prefix for all
# projects, or set individual ones
PROJECT_DIR_PATH="\${HOME}/bigdata"
# HADOOP_DIR_PATH=""
# HBASE_DIR_PATH=""
# KAFKA_DIR_PATH=""
# MAHOUT_DIR_PATH=""
# PHOENIX_DIR_PATH=""
# PIG_DIR_PATH=""
# SPARK_DIR_PATH=""
# STORM_DIR_PATH=""
# ZOOKEEPER_DIR_PATH=""

JAVA16PATH="/usr/lib/jvm/jre-1.6.0/"
JAVA17PATH="/usr/lib/jvm/jre-1.7.0/"
JAVA18PATH="/usr/lib/jvm/jre-1.8.0/"
DEFAULT_JAVA_HOME=$JAVA18PATH

# Adjust accordingly, most of you probably want ssh instead of mrsh
REMOTE_CMD=mrsh

DEFAULT_LOCAL_REQUIREMENTS=n
DEFAULT_LOCAL_REQUIREMENTS_FILE=/tmp/mylocal

# Adjust accordingly.  On very busy clusters/machines, SHUTDOWN_TIME may need to be larger.
STARTUP_TIME=10
SHUTDOWN_TIME=20

# Don't edit these, calculated based on the above
basenodeszookeepernodesmorenodescount=`expr ${basenodecount} \* 2 + ${zookeepernodecount} + 1`
basenodesmorenodescount=`expr ${basenodecount} \* 2 + 1`
basenodeszookeepernodescount=`expr ${basenodecount} + ${zookeepernodecount} + 1`
basenodescount=`expr ${basenodecount} + 1`
