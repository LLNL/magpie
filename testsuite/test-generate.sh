#!/bin/sh

# Which tests to generate
#
# Presently supports
#
# Hadoop 2.2.0, 2.3.0, 2.4.0, 2.4.1, 2.5.0, 2.5.1, 2.5.2, 2.6.0,
# 2.6.1, 2.6.2, 2.6.3, 2.6.4, 2.7.0, 2.7.1, 2.7.2
# Pig 0.12.0, 0.12.1, 0.13.0, 0.14.0, 0.15.0
# Mahout 0.11.0, 0.11.1, 0.11.2, 0.12.0, 0.12.1
# Hbase 0.98.3-bin-hadoop2, 0.98.9-bin-hadoop2, 0.99.0, 0.99.1,
#   0.99.2, 1.0.0, 1.0.1, 1.0.1.1, 1.0.2, 1.1.0, 1.1.0.1, 1.1.1, 1.1.2,
#   1.1.3, 1.1.4, 1.2.0, 1.2.1
# Phoenix 4.5.1-Hbase-1.1, 4.5.2-HBase-1.1, 4.6.0-HBase-1.1
#   4.7.0-Hbase-1.1
# Spark 0.9.1-bin-hadoop2, 0.9.2-bin-hadoop2, 1.2.0-bin-hadoop2.4,
#   1.2.1-bin-hadoop2.4, 1.2.2-bin-hadoop2.4, 1.3.0-bin-hadoop2.4,
#   1.3.1-bin-hadoop2.4, 1.4.0-bin-hadoop2.6, 1.4.1-bin-hadoop2.6,
#   1.5.0-bin-hadoop2.6, 1.5.1-bin-hadoop2.6, 1.5.2-bin-hadoop2.6,
#   1.6.0-bin-hadoop2.6, 1.6.1-bin-hadoop2.6
# Kafka 2.11-0.9.0.0
# Storm 0.9.3, 0.9.4, 0.9.5, 0.9.6, 0.10.0
# Zookeeper 3.4.0, 3.4.1, 3.4.2, 3.4.3, 3.4.4, 3.4.5, 3.4.6, 3.4.7
#   3.4.8
#
# Assumes network file system such as lustre is always available
#
# Assumes current defaults in Magpie are definitely available, but
# versions can be configured for which tests will run
#
# XXX - haven't handled msub-torque-pdsh yet

source test-generate-default.sh
source test-generate-hadoop.sh
source test-generate-hbase.sh
source test-generate-kafka.sh
source test-generate-mahout.sh
source test-generate-phoenix.sh
source test-generate-pig.sh
source test-generate-spark.sh
source test-generate-storm.sh
source test-generate-zookeeper.sh
source test-generate-common.sh

# Job Submission Config

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

msubslurmsrunpartition=mycluster
msubslurmsrunbatchqueue=pbatch

sbatchsrunpartition=pc6220

lsfqueue=standard

# Test config

# Toggle y/n for different test types

# High Level, what tests to generate
# - specific versions can be configured below

defaulttests=y
hadooptests=y
pigtests=y
mahouttests=y
hbasetests=y
phoenixtests=y
sparktests=y
stormtests=y
kafkatests=y
zookeepertests=y

# Higher level configuration, add or eliminate certain types of tests
#
# defaultonly: only default tests, simple sanity checks
# standardtests: basic tests, terasort, sparkpi, etc.
# dependencytests: check dependencies
# regressiontests: regression tests
# local_drive_tests - anything that uses a local drive (HDFS on disk, zookeeper local, etc.)
# hdfsoverlustre_tests - anything that uses hdfs over lustre
# hdfsovernetworkfs_tests - anything that uses hdfs over networkfs 
# nolocaldirtests - using MAGPIE_NO_LOCAL_DIR
defaultonly=n
standardtests=y
dependencytests=y
regressiontests=y
local_drive_tests=y
hdfsoverlustre_tests=y
hdfsovernetworkfs_tests=y
nolocaldirtests=y

# Version specific tests, set to y to test, n to not
hadoop_2_2_0=y
hadoop_2_3_0=y
hadoop_2_4_0=y
hadoop_2_4_1=y
hadoop_2_5_0=y
hadoop_2_5_1=y
hadoop_2_5_2=y
hadoop_2_6_0=y
hadoop_2_6_1=y
hadoop_2_6_2=y
hadoop_2_6_3=y
hadoop_2_6_4=y
hadoop_2_7_0=y
hadoop_2_7_1=y
hadoop_2_7_2=y
pig_0_12_0=y
pig_0_12_1=y
pig_0_13_0=y
pig_0_14_0=y
pig_0_15_0=y
mahout_0_11_0=y
mahout_0_11_1=y
mahout_0_11_2=y
mahout_0_12_0=y
mahout_0_12_1=y
hbase_0_98_3_hadoop2=y
hbase_0_98_9_hadoop2=y
hbase_0_99_0=y
hbase_0_99_1=y
hbase_0_99_2=y
hbase_1_0_0=y
hbase_1_0_0_1=y
hbase_1_0_1=y
hbase_1_0_2=y
hbase_1_1_0=y
hbase_1_1_0_1=y
hbase_1_1_1=y
hbase_1_1_2=y
hbase_1_1_3=y
hbase_1_1_4=y
hbase_1_2_0=y
hbase_1_2_1=y
phoenix_4_5_1_HBase_1_1=y
phoenix_4_5_2_HBase_1_1=y
phoenix_4_6_0_HBase_1_1=y
phoenix_4_7_0_HBase_1_1=y
spark_0_9_1_bin_hadoop2=y
spark_0_9_2_bin_hadoop2=y
spark_1_2_0_bin_hadoop2_4=y
spark_1_2_1_bin_hadoop2_4=y
spark_1_2_2_bin_hadoop2_4=y
spark_1_3_0_bin_hadoop2_4=y
spark_1_3_1_bin_hadoop2_4=y
spark_1_4_0_bin_hadoop2_6=y
spark_1_4_1_bin_hadoop2_6=y
spark_1_5_0_bin_hadoop2_6=y
spark_1_5_1_bin_hadoop2_6=y
spark_1_5_2_bin_hadoop2_6=y
spark_1_6_0_bin_hadoop2_6=y
spark_1_6_1_bin_hadoop2_6=y
storm_0_9_3=y
storm_0_9_4=y
storm_0_9_5=y
storm_0_9_6=y
storm_0_10_0=y
kafka_2_11_0_9_0_0=y
zookeeper_3_4_0=y
zookeeper_3_4_1=y
zookeeper_3_4_2=y
zookeeper_3_4_3=y
zookeeper_3_4_4=y
zookeeper_3_4_5=y
zookeeper_3_4_6=y
zookeeper_3_4_7=y
zookeeper_3_4_8=y

# Configure Makefile 

# Remember to escape $ w/ \ if you want the environment variables
# placed into the submission scripts instead of being expanded out

DEFAULT_HADOOP_FILESYSTEM_MODE="hdfsoverlustre"

LOCAL_DIR_PATH="/tmp/\${USER}"
PROJECT_DIR_PATH="\${HOME}/hadoop"
HOME_DIR_PATH="\${HOME}"
LUSTRE_DIR_PATH="/p/lscratchg/\${USER}/testing"
NETWORKFS_DIR_PATH="/p/lscratchg/\${USER}/testing"
ZOOKEEPER_DATA_DIR_PATH="/p/lscratchg/\${USER}/testing"
SSD_DIR_PATH="/ssd/tmp1/\${USER}"

JAVA16PATH="/usr/lib/jvm/jre-1.6.0-sun.x86_64/"
JAVA17PATH="/usr/lib/jvm/jre-1.7.0-oracle.x86_64/"
DEFAULT_JAVA_HOME=$JAVA17PATH

REMOTE_CMD=mrsh

DEFAULT_LOCAL_REQUIREMENTS=n
DEFAULT_LOCAL_REQUIREMENTS_FILE=/tmp/mylocal

# Adjust accordingly.  On very busy clusters/machines, SHUTDOWN_TIME may need to be larger.
STARTUP_TIME=30
SHUTDOWN_TIME=30

MAGPIE_SCRIPTS_HOME=$(cd "`dirname "$0"`"/..; pwd)

if [ ! -d "${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates" ]
then
    echo "${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates not a directory"
    exit 1
fi

magpiescriptshomesubst=`echo ${MAGPIE_SCRIPTS_HOME} | sed "s/\\//\\\\\\\\\//g"`

cp ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save

MAGPIE_SCRIPTS_HOME_DIRNAME=`dirname ${MAGPIE_SCRIPTS_HOME}`
magpiescriptshomedirnamesubst=`echo ${MAGPIE_SCRIPTS_HOME_DIRNAME} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/MAGPIE_SCRIPTS_DIR_PREFIX=\(.*\)/MAGPIE_SCRIPTS_DIR_PREFIX=${magpiescriptshomedirnamesubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

localdirpathsubst=`echo ${LOCAL_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/LOCAL_DIR_PREFIX=\(.*\)/LOCAL_DIR_PREFIX=${localdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

projectdirpathsubst=`echo ${PROJECT_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/PROJECT_DIR_PREFIX=\(.*\)/PROJECT_DIR_PREFIX=${projectdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

homedirpathsubst=`echo ${HOME_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/HOME_DIR_PREFIX=\(.*\)/HOME_DIR_PREFIX=${homedirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

lustredirpathsubst=`echo ${LUSTRE_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/LUSTRE_DIR_PREFIX=\(.*\)/LUSTRE_DIR_PREFIX=${lustredirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

networkfsdirpathsubst=`echo ${NETWORKFS_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/NETWORKFS_DIR_PREFIX=\(.*\)/NETWORKFS_DIR_PREFIX=${networkfsdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

zookeeperdatadirpathsubst=`echo ${ZOOKEEPER_DATA_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/ZOOKEEPER_DATA_DIR_PREFIX=\(.*\)/ZOOKEEPER_DATA_DIR_PREFIX=${zookeeperdatadirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

ssddirpathsubst=`echo ${SSD_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/SSD_DIR_PREFIX=\(.*\)/SSD_DIR_PREFIX=${ssddirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/REMOTE_CMD_DEFAULT=ssh/REMOTE_CMD_DEFAULT=${REMOTE_CMD}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/MAGPIE_NO_LOCAL_DIR=n/MAGPIE_NO_LOCAL_DIR=y/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

defaultlocalreqpathsubstr=`echo ${DEFAULT_LOCAL_REQUIREMENTS_FILE} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/LOCAL_REQUIREMENTS=n/LOCAL_REQUIREMENTS=${DEFAULT_LOCAL_REQUIREMENTS}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/LOCAL_REQUIREMENTS_FILE=\(.*\)/LOCAL_REQUIREMENTS_FILE=${defaultlocalreqpathsubstr}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/HADOOP_FILESYSTEM_MODE=\"\(.*\)\"/HADOOP_FILESYSTEM_MODE=\"${DEFAULT_HADOOP_FILESYSTEM_MODE}\"/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

defaultjavahomesubst=`echo ${DEFAULT_JAVA_HOME} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/JAVA_DEFAULT=\(.*\)/JAVA_DEFAULT=${defaultjavahomesubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

# Replace output filename with common strings so we can do the same
# search & replace later on regardless of the job submission type.

defaultjoboutputfile=FILENAMESEARCHREPLACEPREFIX-FILENAMESEARCHREPLACEKEY.out
sed -i -e "s/SBATCH_SRUN_DEFAULT_JOB_FILE=\(.*\)/SBATCH_SRUN_DEFAULT_JOB_FILE=${defaultjoboutputfile}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/MSUB_SLURM_SRUN_DEFAULT_JOB_FILE=\(.*\)/MSUB_SLURM_SRUN_DEFAULT_JOB_FILE=${defaultjoboutputfile}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE=\(.*\)/MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE=${defaultjoboutputfile}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/LSF_MPIRUN_DEFAULT_JOB_FILE=\(.*\)/LSF_MPIRUN_DEFAULT_JOB_FILE=${defaultjoboutputfile}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

java16pathsubst=`echo ${JAVA16PATH} | sed "s/\\//\\\\\\\\\//g"`
java17pathsubst=`echo ${JAVA17PATH} | sed "s/\\//\\\\\\\\\//g"`

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

echo "Making launching scripts"

make ${submissiontype} &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

if [ "${defaulttests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
	GenerateDefaultStandardTests
    fi
    if [ "${regressiontests}" == "y" ]; then
	GenerateDefaultRegressionTests
    fi
fi

if [ "${defaultonly}" != "y" ]; then
    if [ "${hadooptests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateHadoopStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GenerateHadoopDependencyTests
	fi
    fi
    if [ "${pigtests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GeneratePigStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GeneratePigDependencyTests
	fi
    fi
    if [ "${mahouttests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateMahoutStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GenerateMahoutDependencyTests
	fi
    fi
    if [ "${hbasetests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateHbaseStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GenerateHbaseDependencyTests
	fi
    fi
    if [ "${phoenixtests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GeneratePhoenixStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GeneratePhoenixDependencyTests
	fi
    fi
    if [ "${sparktests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateSparkStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GenerateSparkDependencyTests
	fi
    fi
    if [ "${stormtests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateStormStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GenerateStormDependencyTests
	fi
    fi
    if [ "${kafkatests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateKafkaStandardTests
	fi
	if [ "${dependencytests}" == "y" ]; then
	    GenerateKafkaDependencyTests
	fi
    fi
    if [ "${zookeepertests}" == "y" ]; then
	if [ "${standardtests}" == "y" ]; then
	    GenerateZookeeperStandardTests
	fi
    fi
fi

# Remove any tests we don't want

echo "Removing tests we do not want"

if [ "${local_drive_tests}" == "n" ]
then
    rm -f magpie.${submissiontype}-hadoop*hdfsondisk*
    rm -f magpie.${submissiontype}-hadoop*localstore*
    rm -f magpie.${submissiontype}-*zookeeper-local*
fi

if [ "${hdfsoverlustre_tests}" == "n" ]
then
    rm -f magpie.${submissiontype}-*hdfsoverlustre*
fi

if [ "${hdfsovernetworkfs_tests}" == "n" ]
then
    rm -f magpie.${submissiontype}-*hdfsovernetworkfs*
fi

if [ "${nolocaldirtests}" == "n" ]
then
    rm -f magpie.${submissiontype}*no-local-dir*
fi

if [ "${hadoop_2_2_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.2.0*
fi

if [ "${hadoop_2_3_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.3.0*
fi

if [ "${hadoop_2_4_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.4.0*
fi

if [ "${hadoop_2_4_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.4.1*
fi
if [ "${hadoop_2_5_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.5.0*
fi

if [ "${hadoop_2_5_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.5.1*
fi

if [ "${hadoop_2_5_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.5.2*
fi

if [ "${hadoop_2_6_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.0*
fi

if [ "${hadoop_2_6_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.1*
fi

if [ "${hadoop_2_6_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.2*
fi

if [ "${hadoop_2_6_3}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.3*
fi

if [ "${hadoop_2_6_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.4*
fi

if [ "${hadoop_2_7_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.7.0*
fi

if [ "${hadoop_2_7_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.7.1*
fi

if [ "${hadoop_2_7_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.7.2*
fi

if [ "${pig_0_12_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*pig-0.12.0*
fi

if [ "${pig_0_12_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*pig-0.12.1*
fi

if [ "${pig_0_13_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*pig-0.13.0*
fi

if [ "${pig_0_14_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*pig-0.14.0*
fi

if [ "${pig_0_15_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*pig-0.15.0*
fi

if [ "${mahout_0_11_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*mahout-0.11.0*
fi

if [ "${mahout_0_11_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*mahout-0.11.1*
fi

if [ "${mahout_0_11_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*mahout-0.11.2*
fi

if [ "${mahout_0_12_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*mahout-0.12.0*
fi

if [ "${mahout_0_12_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*mahout-0.12.1*
fi

if [ "${hbase_0_98_3_hadoop2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-0.98.3-hadoop2*
fi

if [ "${hbase_0_98_9_hadoop2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-0.98.9-hadoop2*
fi

if [ "${hbase_0_99_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.0*
fi

if [ "${hbase_0_99_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.1*
fi

if [ "${hbase_0_99_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.2*
fi

if [ "${hbase_1_0_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.0*
fi

if [ "${hbase_1_0_0_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.0.1*
fi

if [ "${hbase_1_0_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.1*
fi

if [ "${hbase_1_0_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.2*
fi

if [ "${hbase_1_1_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.0*
fi

if [ "${hbase_1_1_0_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.0.1*
fi

if [ "${hbase_1_1_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.1*
fi

if [ "${hbase_1_1_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.2*
fi

if [ "${hbase_1_1_3}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.3*
fi

if [ "${hbase_1_1_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.4*
fi

if [ "${hbase_1_2_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.2.0*
fi

if [ "${hbase_1_2_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*hbase-1.2.1*
fi

if [ "${phoenix_4_5_1_HBase_1_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.5.1-HBase-1.1*
fi

if [ "${phoenix_4_5_2_HBase_1_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.5.2-HBase-1.1*
fi

if [ "${phoenix_4_6_0_HBase_1_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.6.0-HBase-1.1*
fi

if [ "${phoenix_4_7_0_HBase_1_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.7.0-HBase-1.1*
fi

if [ "${spark_0_9_1_bin_hadoop2}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.1-bin-hadoop2*
fi

if [ "${spark_0_9_2_bin_hadoop2}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.2-bin-hadoop2*
fi

if [ "${spark_1_2_0_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.0-bin-hadoop2.4*
fi

if [ "${spark_1_2_1_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.1-bin-hadoop2.4*
fi

if [ "${spark_1_2_2_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.2-bin-hadoop2.4*
fi

if [ "${spark_1_3_0_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.0-bin-hadoop2.4*
fi

if [ "${spark_1_3_1_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.1-bin-hadoop2.4*
fi

if [ "${spark_1_4_0_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.0-bin-hadoop2.6*
fi

if [ "${spark_1_4_1_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.1-bin-hadoop2.6*
fi

if [ "${spark_1_5_0_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.0-bin-hadoop2.6*
fi

if [ "${spark_1_5_1_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.1-bin-hadoop2.6*
fi

if [ "${spark_1_5_2_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.2-bin-hadoop2.6*
fi

if [ "${spark_1_6_0_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.6.0-bin-hadoop2.6*
fi

if [ "${spark_1_6_1_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.6.1-bin-hadoop2.6*
fi

if [ "${storm_0_9_3}" == "n" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.3*
fi

if [ "${storm_0_9_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.4*
fi

if [ "${storm_0_9_5}" == "n" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.5*
fi

if [ "${storm_0_9_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.6*
fi

if [ "${storm_0_10_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*storm-0.10.0*
fi

if [ "${kafka_2_11_0_9_0_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*kafka-2.11-0.9.0.0*
fi

if [ "${zookeeper_3_4_0}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.0*
fi

if [ "${zookeeper_3_4_1}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.1*
fi

if [ "${zookeeper_3_4_2}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.2*
fi

if [ "${zookeeper_3_4_3}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.3*
fi

if [ "${zookeeper_3_4_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.4*
fi

if [ "${zookeeper_3_4_5}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.5*
fi

if [ "${zookeeper_3_4_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.6*
fi

if [ "${zookeeper_3_4_7}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.7*
fi

if [ "${zookeeper_3_4_8}" == "n" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.8*
fi

# Seds for all tests

echo "Finishing up test creation"

# Names important, will be used in validation

if ls magpie.${submissiontype}*run-hadoopterasort* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hadoopterasort-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-hadoopterasort*
fi
if ls magpie.${submissiontype}-hadoop*run-scriptteragen* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scriptteragen-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop*run-scriptteragen*
fi
if ls magpie.${submissiontype}-hadoop*run-scriptterasort* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scriptterasort-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop*run-scriptterasort*
fi
if ls magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hadoopupgradehdfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs*
fi
if ls magpie.${submissiontype}*decommissionhdfsnodes* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/decommissionhdfsnodes-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*decommissionhdfsnodes*
fi

if ls magpie.${submissiontype}*hdfs-fewer-nodes*expected-failure* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-fewer-nodes-expected-failure-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*hdfs-fewer-nodes*expected-failure*
fi
if ls magpie.${submissiontype}*hdfs-older-version*expected-failure* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-older-version-expected-failure-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*hdfs-older-version*expected-failure*
fi
if ls magpie.${submissiontype}*hdfs-newer-version*expected-failure* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-newer-version-expected-failure-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*hdfs-newer-version*expected-failure*
fi

if ls magpie.${submissiontype}*run-testpig* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-testpig-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-testpig*
fi
if ls magpie.${submissiontype}*run-pigscript* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-pigscript-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-pigscript*
fi

if ls magpie.${submissiontype}*run-clustersyntheticcontrol* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-clustersyntheticcontrol-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-clustersyntheticcontrol*
fi

if ls magpie.${submissiontype}*run-hbaseperformanceeval* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-hbaseperformanceeval-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-hbaseperformanceeval*
fi
if ls magpie.${submissiontype}*run-scripthbasewritedata* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scripthbasewritedata-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-scripthbasewritedata*
fi
if ls magpie.${submissiontype}*run-scripthbasereaddata* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-scripthbasereaddata-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-scripthbasereaddata*
fi

if ls magpie.${submissiontype}*run-phoenixperformanceeval* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-phoenixperformanceeval-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-phoenixperformanceeval*
fi
if ls magpie.${submissiontype}*run-stormwordcount* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-stormwordcount-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-stormwordcount*
fi

if ls magpie.${submissiontype}*run-sparkpi* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-sparkpi-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-sparkpi*
fi
if ls magpie.${submissiontype}*run-sparkwordcount* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-sparkwordcount-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-sparkwordcount*
fi
if ls magpie.${submissiontype}*run-pysparkwordcount* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-pysparkwordcount-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-pysparkwordcount*
fi

if ls magpie.${submissiontype}*hdfs-more-nodes* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/hdfs-more-nodes-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*hdfs-more-nodes*
fi

if ls magpie.${submissiontype}*spark-with-rawnetworkfs* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/rawnetworkfs-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*spark-with-rawnetworkfs*
fi

if ls magpie.${submissiontype}*run-kafkaperformance* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-kafkaperformance-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-kafkaperformance*
fi

if ls magpie.${submissiontype}*run-zookeeperruok* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/run-zookeeperruok-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*run-zookeeperruok*
fi

if ls magpie.${submissiontype}*zookeeper-shared* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/zookeeper-shared-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*zookeeper-shared*
fi

if ls magpie.${submissiontype}*Dependency* >& /dev/null ; then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/Dependency-FILENAMESEARCHREPLACEKEY/" magpie.${submissiontype}*Dependency*
fi

if ls magpie.${submissiontype}*no-local-dir >& /dev/null ; then
    sed -i -e 's/# export MAGPIE_NO_LOCAL_DIR="yes"/export MAGPIE_NO_LOCAL_DIR="yes"/' magpie.${submissiontype}*no-local-dir
fi

# special node sizes first
if ls magpie.${submissiontype}-hbase-with-hdfs*hdfs-more-nodes* >& /dev/null ; then
    sed -i -e "s/<my node count>/20/" magpie.${submissiontype}-hbase-with-hdfs*hdfs-more-nodes*
fi
if ls magpie.${submissiontype}*hdfs-more-nodes* >& /dev/null ; then
    sed -i -e "s/<my node count>/17/" magpie.${submissiontype}*hdfs-more-nodes*
fi
if ls magpie.${submissiontype}-hbase-with-hdfs*hdfs-fewer-nodes* >& /dev/null ; then
    sed -i -e "s/<my node count>/12/" magpie.${submissiontype}-hbase-with-hdfs*hdfs-fewer-nodes*
fi
if ls magpie.${submissiontype}*hdfs-fewer-nodes* >& /dev/null ; then
    sed -i -e "s/<my node count>/9/" magpie.${submissiontype}*hdfs-fewer-nodes*
fi
if ls magpie.${submissiontype}-hbase-with-hdfs* >& /dev/null ; then
    sed -i -e "s/<my node count>/12/" magpie.${submissiontype}-hbase-with-hdfs* 
fi
if ls magpie.${submissiontype}-storm* >& /dev/null ; then
    sed -i -e "s/<my node count>/12/" magpie.${submissiontype}-storm*
fi

sed -i -e "s/<my node count>/9/" magpie.${submissiontype}*

sed -i -e "s/<my job name>/test/" magpie.${submissiontype}*

ls magpie.${submissiontype}* | grep -v Dependency | xargs sed -i -e 's/# export HADOOP_PER_JOB_HDFS_PATH="yes"/export HADOOP_PER_JOB_HDFS_PATH="yes"/'
ls magpie.${submissiontype}* | grep -v Dependency | xargs sed -i -e 's/# export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/'

sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\${HOME}\/magpie-my-post-job-script"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' magpie.${submissiontype}*

dependencyprefix=`date +"%Y%m%d%N"`

sed -i -e "s/DEPENDENCYPREFIX/${dependencyprefix}/" magpie.${submissiontype}*

# Put back original/desired filename names and do some last replaces that are submission type specific

if [ "${submissiontype}" == "sbatch-srun" ]
then
    sed -i -e "s/FILENAMESEARCHREPLACEPREFIX/slurm/" magpie.${submissiontype}*
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/%j/" magpie.${submissiontype}*

    if ls magpie.${submissiontype}-hbase-with-hdfs* >& /dev/null ; then
	sed -i -e "s/<my time in minutes>/120/" magpie.${submissiontype}-hbase-with-hdfs*
    fi
    sed -i -e "s/<my time in minutes>/90/" magpie.${submissiontype}*

    sed -i -e "s/<my partition>/${sbatchsrunpartition}/" magpie.${submissiontype}*
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    sed -i -e "s/FILENAMESEARCHREPLACEPREFIX/moab/" magpie.${submissiontype}*
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/%j/" magpie.${submissiontype}*

    if ls magpie.${submissiontype}-hbase-with-hdfs* >& /dev/null ; then
	sed -i -e "s/<my time in seconds or HH:MM:SS>/7200/" magpie.${submissiontype}-hbase-with-hdfs*
    fi
    sed -i -e "s/<my time in seconds or HH:MM:SS>/5400/" magpie.${submissiontype}*

    sed -i -e "s/<my partition>/${msubslurmsrunpartition}/" magpie.${submissiontype}*
    sed -i -e "s/<my batch queue>/${msubslurmsrunbatchqueue}/" magpie.${submissiontype}*
elif [ "${submissiontype}" == "lsf-mpirun" ]
then
    sed -i -e "s/FILENAMESEARCHREPLACEPREFIX/lsf/" magpie.${submissiontype}*
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/%J/" magpie.${submissiontype}*

    if ls magpie.${submissiontype}-hbase-with-hdfs* >& /dev/null ; then
	sed -i -e "s/<my time in hours:minutes>/2:00/" magpie.${submissiontype}-hbase-with-hdfs*
    fi
    sed -i -e "s/<my time in hours:minutes>/1:30/" magpie.${submissiontype}*

    sed -i -e "s/<my queue>/${lsfqueue}/" magpie.${submissiontype}*
fi

echo "Setting original submission scripts back to prior default"

cp ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

rm -f ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

make ${submissiontype} &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

sed -i -e 's/# export MAGPIE_STARTUP_TIME=.*/export MAGPIE_STARTUP_TIME='"${STARTUP_TIME}"'/' magpie.${submissiontype}*
sed -i -e 's/# export MAGPIE_SHUTDOWN_TIME=.*/export MAGPIE_SHUTDOWN_TIME='"${SHUTDOWN_TIME}"'/' magpie.${submissiontype}*

