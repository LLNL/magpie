#!/bin/sh

# Which tests to generate
#
# Presently supports
#
# Hadoop 2.2.0, 2.3.0, 2.4.0, 2.4.1, 2.5.0, 2.5.1, 2.5.2, 2.6.0,
# 2.6.1, 2.7.0, 2.7.1
# Pig 0.12.0, 0.12.1, 0.13.0, 0.14.0, 0.15.0
# Mahout 0.11.0, 0.11.1
# Hbase 0.98.3-bin-hadoop2, 0.98.9-bin-hadoop2, 0.99.0, 0.99.1,
#   0.99.2, 1.0.0, 1.0.1, 1.0.1.1, 1.0.2, 1.1.0, 1.1.0.1, 1.1.1, 1.1.2
# Phoenix 4.5.1-Hbase-1.1, 4.5.2-HBase-1.1, 4.6.0-HBase-1.1
# Spark 0.9.1-bin-hadoop2, 0.9.2-bin-hadoop2, 1.2.0-bin-hadoop2.4,
#   1.2.1-bin-hadoop2.4, 1.2.2-bin-hadoop2.4, 1.3.0-bin-hadoop2.4,
#   1.3.1-bin-hadoop2.4, 1.4.0-bin-hadoop2.6, 1.4.1-bin-hadoop2.6,
#   1.5.0-bin-hadoop2.6, 1.5.1-bin-hadoop2.6, 1.5.2-bin-hadoop2.6

# Storm 0.9.3, 0.9.4, 0.9.5
# Zookeeper 3.4.0, 3.4.1, 3.4.2, 3.4.3, 3.4.4, 3.4.5, 3.4.6
#
# Assumes network file system such as lustre is always available
#
# Assumes current defaults in Magpie are definitely available, but
# versions can be configured for which tests will run
#
# XXX - haven't handled lsf-mpirun, msub-slurm-srun, or msub-torque-pdsh yet

# Job Submission Config

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

msubslurmsrunpartition=mycluster
msubslurmsrunbatchqueue=pbatch

sbatchsrunpartition=pc6220

# Test config

no_local_ssd_tests=n
no_hadoop_2_2_0=n
no_hadoop_2_3_0=n
no_hadoop_2_4_0=n
no_hadoop_2_4_1=n
no_hadoop_2_5_0=n
no_hadoop_2_5_1=n
no_hadoop_2_5_2=n
no_hadoop_2_6_0=n
no_hadoop_2_6_1=n
no_hadoop_2_7_0=n
no_hadoop_2_7_1=n
no_pig_0_12_0=n
no_pig_0_12_1=n
no_pig_0_13_0=n
no_pig_0_14_0=n
no_pig_0_15_0=n
no_mahout_0_11_0=n
no_mahout_0_11_1=n
no_hbase_0_98_3_bin_hadoop2=n
no_hbase_0_98_9_bin_hadoop2=n
no_hbase_0_99_0=n
no_hbase_0_99_1=n
no_hbase_0_99_2=n
no_hbase_1_0_0=n
no_hbase_1_0_0_1=n
no_hbase_1_0_1=n
no_hbase_1_0_2=n
no_hbase_1_1_0=n
no_hbase_1_1_0_1=n
no_hbase_1_1_1=n
no_hbase_1_1_2=n
no_phoenix_4_5_1_HBase_1_1=n
no_phoenix_4_5_2_HBase_1_1=n
no_phoenix_4_6_0_HBase_1_1=n
no_spark_0_9_1_bin_hadoop2=n
no_spark_0_9_2_bin_hadoop2=n
no_spark_1_2_0_bin_hadoop2_4=n
no_spark_1_2_1_bin_hadoop2_4=n
no_spark_1_2_2_bin_hadoop2_4=n
no_spark_1_3_0_bin_hadoop2_4=n
no_spark_1_3_1_bin_hadoop2_4=n
no_spark_1_4_0_bin_hadoop2_6=n
no_spark_1_4_1_bin_hadoop2_6=n
no_spark_1_5_0_bin_hadoop2_6=n
no_spark_1_5_1_bin_hadoop2_6=n
no_spark_1_5_2_bin_hadoop2_6=n
no_storm_0_9_3=n
no_storm_0_9_4=n
no_storm_0_9_5=n
no_zookeeper_3_4_0=n
no_zookeeper_3_4_1=n
no_zookeeper_3_4_2=n
no_zookeeper_3_4_3=n
no_zookeeper_3_4_4=n
no_zookeeper_3_4_5=n
no_zookeeper_3_4_6=n

# Configure Makefile 

# Remember to escape $ w/ \ if you want the environment variables
# placed into the submission scripts instead of being expanded out

DEFAULT_HADOOP_FILESYSTEM_MODE="hdfsoverluster"

LOCAL_DIR_PATH="/tmp/\${USER}"
PROJECT_DIR_PATH="\${HOME}/hadoop"
HOME_DIR_PATH="\${HOME}"
LUSTRE_DIR_PATH="/p/lscratchg/\${USER}/testing"
NETWORKFS_DIR_PATH="/p/lscratchg/\${USER}/testing"
SSD_DIR_PATH="/ssd/tmp1/\${USER}"

JAVA16PATH="/usr/lib/jvm/jre-1.6.0-sun.x86_64/"
JAVA17PATH="/usr/lib/jvm/jre-1.7.0-oracle.x86_64/"

REMOTE_CMD=mrsh

DEFAULT_LOCAL_REQUIREMENTS=n
DEFAULT_LOCAL_REUQIREMENTS_FILE=/tmp/mylocal

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

ssddirpathsubst=`echo ${SSD_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/SSD_DIR_PREFIX=\(.*\)/SSD_DIR_PREFIX=${ssddirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/REMOTE_CMD_DEFAULT=ssh/REMOTE_CMD_DEFAULT=${REMOTE_CMD}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/MAGPIE_NO_LOCAL_DIR=n/MAGPIE_NO_LOCAL_DIR=y/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

defaultlocalreqpathsubstr=`echo ${DEFAULT_LOCAL_REQUIREMENTS_FILE} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/LOCAL_REQUIREMENTS=n/LOCAL_REQUIREMENTS=${DEFAULT_LOCAL_REQUIREMENTS}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/LOCAL_REQUIREMENTS_FILE="\(.*\)"/LOCAL_REQUIREMENTS_FILE=${defaultlocalreqpathsubstring}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

java16pathsubst=`echo ${JAVA16PATH} | sed "s/\\//\\\\\\\\\//g"`
java17pathsubst=`echo ${JAVA17PATH} | sed "s/\\//\\\\\\\\\//g"`

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

echo "Making launching scripts"

make &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

echo "Making Default tests"

# Default Tests

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-run-hadoopterasort
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-run-testpig
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-run-sparkpi
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-storm-run-stormwordcount
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-run-zookeeperruok

sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-run-zookeeperruok
sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok
sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok

# Default No Local Dir Tests

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-run-hadoopterasort-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-run-testpig-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout magpie.${submissiontype}-hadoop-and-mahout-run-clustersyntheticcontrol-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-run-hbaseperformanceeval-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-run-phoenixperformanceeval-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-run-sparkpi-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-run-sparkwordcount-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-run-stormwordcount-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir

sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir
sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-run-zookeeperruok-no-local-dir

# Set HADOOP_FILESYTEM_MODE on defaults
sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="'"${DEFAULT_HADOOP_FILESYSTEM_MODE}"'"/' ./magpie.${submissiontype}-*

# Dependency 1 tests, run different things after one another - Hadoop 2.2.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.2.0-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.2.0-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.2.0-pig-0.12.0-run-testpig

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.12.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.2.0-pig-0.12.0-run-testpig

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.9-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1A"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-spark-0.9.1-bin-hadoop2-run-sparkwordcount

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="0.9.1-bin-hadoop2"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.2.0-spark-0.9.1-bin-hadoop2-run-sparkwordcount

# Dependency 1 tests, run different things after one another - Hadoop 2.4.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.4.0-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.4.0-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.4.0-pig-0.12.0-run-testpig

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.12.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.4.0-pig-0.12.0-run-testpig

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.9-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1B"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount

# Dependency 1 tests, run different things after one another - Hadoop 2.6.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.6.0-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.6.0-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.6.0-pig-0.14.0-run-testpig

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.14.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.6.0-pig-0.14.0-run-testpig

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.9-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1C"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6-run-hbaseperformanceeval

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4-run-sparkwordcount

# Dependency 1 tests, run different things after one another - Hadoop 2.7.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1D-hadoop-2.7.0-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1D\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1D-hadoop-2.7.0-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1D-hadoop-2.7.0-pig-0.15.0-run-testpig

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1D\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.15.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1D-hadoop-2.7.0-pig-0.15.0-run-testpig

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-DependencyGlobalOrder1D-hadoop-2.7.0-mahout-0.11.1-run-clustersyntheticcontrol

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1D\/"/' \
    -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="0.11.1"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    ./magpie.${submissiontype}-hadoop-and-mahout-DependencyGlobalOrder1D-hadoop-2.7.0-mahout-0.11.1-run-clustersyntheticcontrol

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-hbase-1.1.2-zookeeper-3.4.6-run-hbaseperformanceeval

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1D\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="1.1.2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1D"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-hbase-1.1.2-zookeeper-3.4.6-run-hbaseperformanceeval

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-spark-1.5.0-bin-hadoop2.6-run-sparkwordcount

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1D\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.5.0-bin-hadoop2.6"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1D-hadoop-2.7.0-spark-1.5.0-bin-hadoop2.6-run-sparkwordcount

# Hadoop Tests
# Note, b/c of MAPREDUCE-5528, not testing rawnetworkfs w/ terasort

echo "Making Hadoop tests"

for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-single-path*

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*

    sed -i -e 's/# export HADOOP_TERASORT_SIZE=\(.*\)/export HADOOP_TERASORT_SIZE=10000000000/' magpie.${submissiontype}-hadoop-${hadoopversion}*largeperformancerun*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
done

for hadoopversion in 2.7.0 2.7.1
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-single-path*

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*

    sed -i -e 's/# export HADOOP_TERASORT_SIZE=\(.*\)/export HADOOP_TERASORT_SIZE=10000000000/' magpie.${submissiontype}-hadoop-${hadoopversion}*largeperformancerun*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
done

# Dependency Tests for Hadoop

# Dependency 1 Tests, run after another

for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
    
    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
done

for hadoopversion in 2.7.0 2.7.1
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
    
    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop1A\/'"${hadoopversion}"'\/"/' \
	./magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}*
done

# Dependency 2 tests, upgrade hdfs, 2.4.0 -> 2.5.0 -> 2.6.0 -> 2.7.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfs-older-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfs-older-version-expected-failure

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-run-hadoopupgradehdfs

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-run-hadoopupgradehdfs

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version-expected-failure

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-run-hadoopupgradehdfs

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-run-hadoopupgradehdfs

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfs-older-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfs-older-version-expected-failure

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-run-hadoopupgradehdfs

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-run-hadoopupgradehdfs

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-run-hadoopterasort

# Dependency 3 test, increase size

for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    
    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*

    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsoverlustre*

    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsovernetworkfs*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*
done

for hadoopversion in 2.7.0 2.7.1 
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    
    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*
    
    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsoverlustre*
    
    sed -i \
	-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop3A\/'"${hadoopversion}"'\/"/' \
	magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*hdfsovernetworkfs*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A*
done

# Dependency 4 test, detect newer hdfs version 2.3.0 from 2.2.0, HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4A-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4A-hdfs-newer-version-expected-failure

# Dependency 4 test detect newer hdfs version 2.3.0 from 2.2.0, HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4B-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4B-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4B-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.2.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4B-hdfs-newer-version-expected-failure

# Dependency 5 test, detect newer hdfs version 2.4.0 from 2.3.0, HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5A-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5A-hdfs-newer-version-expected-failure

# Dependency 5 test detect newer hdfs version 2.4.0 from 2.3.0, HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5B-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5B-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5B-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.3.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5B-hdfs-newer-version-expected-failure

# Dependency 6 test, detect newer hdfs version 2.5.0 from 2.4.0, HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6A-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop6A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6A-hdfs-newer-version-expected-failure

# Dependency 6 test detect newer hdfs version 2.5.0 from 2.4.0, HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6B-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop6B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6B-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6B-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop6B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6B-hdfs-newer-version-expected-failure

# Dependency 7 test, detect newer hdfs version 2.6.0 from 2.5.0, HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7A-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop7A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7A-hdfs-newer-version-expected-failure

# Dependency 7 test detect newer hdfs version 2.6.0 from 2.5.0, HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7B-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop7B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7B-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7B-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.5.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop7B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7B-hdfs-newer-version-expected-failure

# Dependency 8 test, detect newer hdfs version 2.7.0 from 2.6.0 HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8A-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8A-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8A-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop8A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8A-hdfs-newer-version-expected-failure
 
# Dependency 8 test, detect newer hdfs version 2.7.0 from 2.6.0 HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8B-run-hadoopterasort

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop8B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8B-run-hadoopterasort

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8B-hdfs-newer-version-expected-failure

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop8B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8B-hdfs-newer-version-expected-failure

# Pig Tests

echo "Making Pig tests"

for pigversion in 0.12.0 0.12.1
do
    for hadoopversion in 2.4.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*

	sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/mytestpig.sh"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    done
done

for pigversion in 0.13.0 0.14.0
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*

	sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/mytestpig.sh"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    done
done

for pigversion in 0.15.0
do
    for hadoopversion in 2.7.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*

	sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/mytestpig.sh"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*run-pigscript*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    done
done

# Dependency 1 Tests, run after another, HDFS over Lustre

for pigversion in 0.12.0 0.12.1
do
    for hadoopversion in 2.4.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Pig1A\/'"${pigversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    done
done

for pigversion in 0.13.0 0.14.0
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Pig1A\/'"${pigversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    done
done

for pigversion in 0.15.0
do
    for hadoopversion in 2.7.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
	
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Pig1A\/'"${pigversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    done
done

# Dependency 1 Tests, run after another, HDFS over Networkfs

for pigversion in 0.12.0 0.12.1
do
    for hadoopversion in 2.4.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Pig1B\/'"${pigversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    done
done

for pigversion in 0.13.0 0.14.0
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Pig1B\/'"${pigversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    done
done

for pigversion in 0.15.0
do
    for hadoopversion in 2.7.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
	
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Pig1B\/'"${pigversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1B-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    done
done

echo "Making Mahout tests"

for mahoutversion in 0.11.0 0.11.1
do
    for hadoopversion in 2.7.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*

	sed -i -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}*
    done
done

# Dependency 1 Tests, run after another

for mahoutversion in 0.11.0 0.11.1
do
    for hadoopversion in 2.7.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Mahout1A\/'"${mahoutversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
    done
done

for mahoutversion in 0.11.0 0.11.1
do
    for hadoopversion in 2.7.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-mahout ./magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1B-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export MAHOUT_VERSION="\(.*\)"/export MAHOUT_VERSION="'"${mahoutversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Mahout1B\/'"${mahoutversion}"'"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1B-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
    done
done

# Hbase Tests

echo "Making Hbase tests"

for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
do
    for hadoopversion in 2.6.0
    do
	for zookeeperversion in 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-zookeeper-networkfs-shared-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-zookeeper-networkfs-shared-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    
	    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    
	    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*
	    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*sequential-thread*
	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-thread*
	    
	    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	    
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	done
    done
done

for hbaseversion in 0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2
do
    for hadoopversion in 2.7.0
    do
	for zookeeperversion in 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-sequential-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-not-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-networkfs-run-hbaseperformanceeval-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-random-thread-zookeeper-shared-zookeeper-local-run-hbaseperformanceeval-no-local-dir
	    
	    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    
	    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*
	    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*sequential-thread*
	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="\(.*\)"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-thread*
	    
	    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	    
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	done
    done
done

# Dependency 1 Tests, run after another, HFDS over Lustre

for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
do
    for hadoopversion in 2.6.0
    do
	for zookeeperversion in 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval

	    sed -i \
		-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
		-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1A\/'"${hbaseversion}"'"/' \
		-e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		-e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		-e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		-e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1A\/'"${hbaseversion}"'"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
		./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
	done
    done
done

for hbaseversion in 0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2
do
    for hadoopversion in 2.7.0
    do
	for zookeeperversion in 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval

	    sed -i \
		-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
		-e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1A\/'"${hbaseversion}"'"/' \
		-e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		-e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		-e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		-e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1A\/'"${hbaseversion}"'"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1A-hdfsoverlustre-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
	done
    done
done

# Dependency 1 Tests, run after another, HFDS over NetworkFS

for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
do
    for hadoopversion in 2.6.0
    do
	for zookeeperversion in 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1B-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval

	    sed -i \
		-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
		-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hbase1B\/'"${hbaseversion}"'"/' \
		-e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		-e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		-e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		-e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1B\/'"${hbaseversion}"'"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
		./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1B-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
	done
    done
done

for hbaseversion in 0.99.0 0.99.1 0.99.2 1.0.0 1.0.1 1.0.1.1 1.0.2 1.1.0 1.1.0.1 1.1.1 1.1.2
do
    for hadoopversion in 2.7.0
    do
	for zookeeperversion in 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1B-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval

	    sed -i \
		-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		-e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
		-e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hbase1B\/'"${hbaseversion}"'"/' \
		-e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		-e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		-e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		-e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1B\/'"${hbaseversion}"'"/' \
		-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1B-hdfsovernetworkfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
	done
    done
done

# Phoenix Tests

echo "Making Phoenix tests"

for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
do
    for hbaseversion in 1.1.2
    do
	for hadoopversion in 2.7.0
	do
	    for zookeeperversion in 3.4.6
	    do
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval

		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval
		
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsoverlustre-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir

		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-not-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-networkfs-run-phoenixperformanceeval-no-local-dir
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-hdfsovernetworkfs-performanceeval-zookeeper-shared-zookeeper-local-run-phoenixperformanceeval-no-local-dir
		
		sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
		sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
		sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
		sed -i -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
		
		sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsoverlustre*
		sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*hdfsovernetworkfs*

		sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

		sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

		sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
		sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
		
		sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
		sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

		sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    done
	done
    done
done

# Dependency 1 Tests, run after another, HFDS over Lustre

for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
do
    for hbaseversion in 1.1.2
    do
	for hadoopversion in 2.7.0
	do
	    for zookeeperversion in 3.4.6
	    do
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval

		sed -i \
		    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
		    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Phoenix1A\/'"${phoenixversion}"'"/' \
		    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		    -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
		    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Phoenix1A\/'"${phoenixversion}"'"/' \
		    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		    ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
	    done
	done
    done
done

# Dependency 1 Tests, run after another, HFDS over NetworkFS

for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
do
    for hbaseversion in 1.1.2
    do
	for hadoopversion in 2.7.0
	do
	    for zookeeperversion in 3.4.6
	    do
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval

		sed -i \
		    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
		    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Phoenix1B\/'"${phoenixversion}"'"/' \
		    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		    -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
		    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Phoenix1B\/'"${phoenixversion}"'"/' \
		    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		    ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix1B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval
	    done
	done
    done
done

# Dependency 2 Tests, run after another with hbase, HFDS over Lustre

for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
do
    for hbaseversion in 1.1.2
    do
	for hadoopversion in 2.7.0
	do
	    for zookeeperversion in 3.4.6
	    do
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval

		sed -i \
		    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
		    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Phoenix2A\/'"${phoenixversion}"'"/' \
		    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		    -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
		    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Phoenix2A\/'"${phoenixversion}"'"/' \
		    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		    ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval

		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval

		sed -i \
		    -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hbase"/' \
		    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
		    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Phoenix2A\/'"${phoenixversion}"'"/' \
		    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		    -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
		    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Phoenix2A\/'"${phoenixversion}"'"/' \
		    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		    ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2A-hdfsoverlustre-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
	    done
	done
    done
done

# Dependency 2 Tests, run after another with hbase, HFDS over NetworkFS

for phoenixversion in 4.5.1-HBase-1.1 4.5.2-HBase-1.1 4.6.0-HBase-1.1
do
    for hbaseversion in 1.1.2
    do
	for hadoopversion in 2.7.0
	do
	    for zookeeperversion in 3.4.6
	    do
		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval

		sed -i \
		    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
		    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Phoenix2B\/'"${phoenixversion}"'"/' \
		    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		    -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
		    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Phoenix2B\/'"${phoenixversion}"'"/' \
		    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		    ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-phoenixperformanceeval

		cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs-with-phoenix ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval

		sed -i \
		    -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="hbase"/' \
		    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
		    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
		    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Phoenix2B\/'"${phoenixversion}"'"/' \
		    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' \
		    -e 's/export PHOENIX_VERSION="\(.*\)"/export PHOENIX_VERSION="'"${phoenixversion}"'"/' \
		    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
		    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Phoenix2B\/'"${phoenixversion}"'"/' \
		    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
		    ./magpie.${submissiontype}-hbase-with-hdfs-with-phoenix-DependencyPhoenix2B-hdfsovernetworkfs-phoenix-${phoenixversion}-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-run-hbaseperformanceeval
	    done
	done
    done
done

# Spark Tests

echo "Making Spark tests"

for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-spark-${sparkversion}*
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir
    
    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-spark-${sparkversion}*
done

for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-spark-${sparkversion}*
done

for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
do
    for hadoopversion in 2.2.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}*

	sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}* ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' ./magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hdfsoverlustre*
	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' ./magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hdfsovernetworkfs*

	sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.${submissiontype}-spark-with*
	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*
	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*

	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-rawnetworkfs*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}*  ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*
    done
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
do
    for hadoopversion in 2.4.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}*

	sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}* ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' ./magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hdfsoverlustre*
	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' ./magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hdfsovernetworkfs*

	sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.${submissiontype}-spark-with*
	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*
	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*

	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-rawnetworkfs*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}* ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*
    done
done

for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsoverlustre-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hdfsovernetworkfs-hadoop-${hadoopversion}-run-sparkwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-run-sparkwordcount-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}*

	sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}* ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' ./magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hdfsoverlustre*
	sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' ./magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hdfsovernetworkfs*
	
	sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.${submissiontype}-spark-with*

	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*
	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*

	sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-rawnetworkfs*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}*hadoop-${hadoopversion}* ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*
    done
done

# Dependency 1 Tests, run after another, HDFS over Lustre

for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
do
    for hadoopversion in 2.2.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
    
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    done
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
do
    for hadoopversion in 2.4.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount
    
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    done
done

for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
	    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1A\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    done
done

# Dependency 1 Tests, run after another, HDFS over Networkfs
 
for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
do
    for hadoopversion in 2.2.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1B\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/mywordcountfile\"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1B\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    done
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
do
    for hadoopversion in 2.4.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1B\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/mywordcountfile\"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
	
	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1B\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    done
done

for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 .5.2-bin-hadoop2.6
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1B\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/mywordcountfile\"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-run-sparkwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount

	sed -i \
	    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
	    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Spark1B\/'"${sparkversion}"'"/' \
	    -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	    -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/'"${lustredirpathsubst}"'\/hdfsovernetworkfs\/mywordcountfile\"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1B-hadoop-${hadoopversion}-spark-${sparkversion}-no-copy-run-sparkwordcount
    done
done

# Dependency 1 Tests, run after another, rawnetworkfs
 
for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-run-sparkwordcount
    
    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark1C\/'"${sparkversion}"'\/mywordcountfile\"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-run-sparkwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-no-copy-run-sparkwordcount

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark1C\/'"${sparkversion}"'\/mywordcountfile\"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-no-copy-run-sparkwordcount
done

for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-run-sparkwordcount

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark1C\/'"${sparkversion}"'\/mywordcountfile\"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-run-sparkwordcount

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-no-copy-run-sparkwordcount

    sed -i \
	-e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' \
	-e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' \
	-e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' \
	-e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${lustredirpathsubst}"'\/rawnetworkfs\/DEPENDENCYPREFIX\/Spark1C\/'"${sparkversion}"'\/mywordcountfile\"/' \
	-e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	./magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark1C-spark-${sparkversion}-no-copy-run-sparkwordcount
done

# Storm Tests

echo "Making Storm tests"

for stormversion in 0.9.3 0.9.4
do
    for zookeeperversion in 3.4.6
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir

	sed -i -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*

	sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
	
	sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
    done
done

for stormversion in 0.9.5
do
    for zookeeperversion in 3.4.6
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-run-stormwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-run-stormwordcount-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-run-stormwordcount-no-local-dir

	sed -i -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*

	sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
	
	sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
    done
done

# Dependency 1 Tests, run after another

for stormversion in 0.9.3 0.9.4
do
    for zookeeperversion in 3.4.6
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount

	sed -i \
	    -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' \
	    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
	    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
	    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Storm1A\/'"${stormversion}"'\/"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java16pathsubst}"'"/' \
	    magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
    done
done

for stormversion in 0.9.5
do
    for zookeeperversion in 3.4.6
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount

	sed -i \
	    -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' \
	    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' \
	    -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' \
	    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Storm1A\/'"${stormversion}"'\/"/' \
	    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' \
	    magpie.${submissiontype}-storm-DependencyStorm1A-storm-${stormversion}-zookeeper-${zookeeperversion}-run-stormwordcount
    done
done

# Zookeeper Tests
 
echo "Making Zookeeper tests"

for zookeeperversion in 3.4.0 3.4.1 3.4.2 3.4.3 3.4.4 3.4.5 3.4.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-run-zookeeperruok-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-run-zookeeperruok-no-local-dir

    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*zookeeper-local*

    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*zookeeper-local* 

    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*zookeeper-networkfs* 
    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*zookeeper-local* 

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="'"${java17pathsubst}"'"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*
done

# Seds for all tests

echo "Finishing up test creation"

# Names important, will be used in validation

if [ "${submissiontype}" == "sbatch-srun" ]
then
    sed -i -e "s/slurm-%j.out/slurm-run-hadoopterasort-%j.out/" magpie.${submissiontype}*run-hadoopterasort*
    sed -i -e "s/slurm-run-hadoopterasort-%j.out/slurm-run-hadoopterasort-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-hadoopterasort*

    sed -i -e "s/slurm-%j.out/slurm-run-hadoopupgradehdfs-%j.out/" magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs

    sed -i -e "s/slurm-%j.out/slurm-hdfs-fewer-nodes-expected-failure-%j.out/" magpie.${submissiontype}-hadoop*hdfs-fewer-nodes*expected-failure
    sed -i -e "s/slurm-%j.out/slurm-hdfs-older-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-older-version*expected-failure
    sed -i -e "s/slurm-%j.out/slurm-hdfs-newer-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-newer-version*expected-failure

    sed -i -e "s/slurm-%j.out/slurm-run-testpig-%j.out/" magpie.${submissiontype}*run-testpig*
    sed -i -e "s/slurm-%j.out/slurm-run-pigscript-%j.out/" magpie.${submissiontype}*run-pigscript*

    sed -i -e "s/slurm-%j.out/slurm-run-clustersyntheticcontrol-%j.out/" magpie.${submissiontype}*run-clustersyntheticcontrol*

    sed -i -e "s/slurm-%j.out/slurm-run-hbaseperformanceeval-%j.out/" magpie.${submissiontype}*run-hbaseperformanceeval*
    sed -i -e "s/slurm-run-hbaseperformanceeval-%j.out/slurm-run-hbaseperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-hbaseperformanceeval*

    sed -i -e "s/slurm-%j.out/slurm-run-phoenixperformanceeval-%j.out/" magpie.${submissiontype}*run-phoenixperformanceeval*
    sed -i -e "s/slurm-run-phoenixperformanceeval-%j.out/slurm-run-phoenixperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-phoenixperformanceeval*

    sed -i -e "s/slurm-%j.out/slurm-run-sparkpi-%j.out/" magpie.${submissiontype}*run-sparkpi*
    sed -i -e "s/slurm-%j.out/slurm-run-sparkwordcount-%j.out/" magpie.${submissiontype}*run-sparkwordcount*
    sed -i -e "s/slurm-run-sparkwordcount-%j.out/slurm-run-sparkwordcount-rawnetworkfs-%j.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*run-sparkwordcount*
    
    sed -i -e "s/slurm-%j.out/slurm-run-stormwordcount-%j.out/" magpie.${submissiontype}*run-stormwordcount*
    sed -i -e "s/slurm-run-stormwordcount-%j.out/slurm-run-stormwordcount-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-stormwordcount*
    
    sed -i -e "s/slurm-%j.out/slurm-run-zookeeperruok-%j.out/" magpie.${submissiontype}*run-zookeeperruok*
    
    sed -i -e "s/-%j.out/-Dependency-%j.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in minutes>/300/" magpie.${submissiontype}-*largeperformancerun*
    sed -i -e "s/<my time in minutes>/90/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-storm* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in minutes>/120/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my partition>/${sbatchsrunpartition}/" magpie*
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    sed -i -e "s/moab-%j.out/moab-run-hadoopterasort-%j.out/" magpie.${submissiontype}*run-hadoopterasort*
    sed -i -e "s/moab-run-hadoopterasort-%j.out/moab-run-hadoopterasort-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-hadoopterasort*

    sed -i -e "s/moab-%j.out/moab-run-hadoopupgradehdfs-%j.out/" magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs

    sed -i -e "s/moab-%j.out/moab-hdfs-fewer-nodes-expected-failure-%j.out/" magpie.${submissiontype}-hadoop*hdfs-fewer-nodes*expected-failure
    sed -i -e "s/moab-%j.out/moab-hdfs-older-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-older-version*expected-failure
    sed -i -e "s/moab-%j.out/moab-hdfs-newer-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-newer-version*expected-failure
    
    sed -i -e "s/moab-%j.out/moab-run-testpig-%j.out/" magpie.${submissiontype}*run-testpig*
    sed -i -e "s/moab-%j.out/moab-run-pigscript-%j.out/" magpie.${submissiontype}*run-pigscript*

    sed -i -e "s/moab-%j.out/moab-run-clustersyntheticcontrol-%j.out/" magpie.${submissiontype}*run-clustersyntheticcontrol*

    sed -i -e "s/moab-%j.out/moab-run-hbaseperformanceeval-%j.out/" magpie.${submissiontype}*run-hbaseperformanceeval*
    sed -i -e "s/moab-run-hbaseperformanceeval-%j.out/moab-run-hbaseperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-hbaseperformanceeval*

    sed -i -e "s/moab-%j.out/moab-run-phoenixperformanceeval-%j.out/" magpie.${submissiontype}*run-phoenixperformanceeval*
    sed -i -e "s/moab-run-phoenixperformanceeval-%j.out/moab-run-phoenixperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-phoenixperformanceeval*

    sed -i -e "s/moab-%j.out/moab-run-sparkpi-%j.out/" magpie.${submissiontype}*run-sparkpi*
    sed -i -e "s/moab-%j.out/moab-run-sparkwordcount-%j.out/" magpie.${submissiontype}*run-sparkwordcount*
    sed -i -e "s/moab-run-sparkwordcount-%j.out/moab-run-sparkwordcount-rawnetworkfs-%j.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*run-sparkwordcount*

    sed -i -e "s/moab-%j.out/moab-run-stormwordcount-%j.out/" magpie.${submissiontype}*run-stormwordcount*
    sed -i -e "s/moab-run-stormwordcount-%j.out/moab-run-stormwordcount-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-stormwordcount*
    
    sed -i -e "s/moab-%j.out/moab-zookeeper-%j.out/" magpie.${submissiontype}-zookeeper*
    
    sed -i -e "s/-%j.out/-Dependency-%j.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in seconds or HH:MM:SS>/18000/" magpie.${submissiontype}-*largeperformancerun*
    sed -i -e "s/<my time in seconds or HH:MM:SS>/5400/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-storm* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in seconds or HH:MM:SS>/7200/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my partition>/${msubslurmsrunpartition}/" magpie*
    sed -i -e "s/<my batch queue>/${msubslurmsrunbatchqueue}/" magpie*
fi
    
sed -i -e 's/# export MAGPIE_NO_LOCAL_DIR="yes"/export MAGPIE_NO_LOCAL_DIR="yes"/' magpie*no-local-dir
    
# special node sizes first
sed -i -e "s/<my node count>/17/" magpie.${submissiontype}*hdfs-more-nodes*
sed -i -e "s/<my node count>/8/" magpie.${submissiontype}*hdfs-fewer-nodes*
sed -i -e "s/<my node count>/9/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-zookeeper*
sed -i -e "s/<my node count>/12/" magpie.${submissiontype}-hbase-with-hdfs* magpie.${submissiontype}-storm* 

sed -i -e "s/<my job name>/test/" magpie*

ls magpie* | grep -v Dependency | xargs sed -i -e 's/# export HADOOP_PER_JOB_HDFS_PATH="yes"/export HADOOP_PER_JOB_HDFS_PATH="yes"/'
ls magpie* | grep -v Dependency | xargs sed -i -e 's/# export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/'

sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\${HOME}\/magpie-my-post-job-script"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' magpie*

dependencyprefix=`date +"%Y%m%d%N"`

sed -i -e "s/DEPENDENCYPREFIX/${dependencyprefix}/" magpie*

echo "Setting original submission scripts back to prior default"

cp ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

rm -f ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

make &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

if [ "${no_local_ssd_tests}" == "y" ]
then
    rm -f magpie.${submissiontype}-hadoop*hdfsondisk*
    rm -f magpie.${submissiontype}-hadoop*localstore*
    rm -f magpie.${submissiontype}-*zookeeper-local*
fi

if [ "${no_hadoop_2_2_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.2.0*
fi

if [ "${no_hadoop_2_3_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.3.0*
fi

if [ "${no_hadoop_2_4_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.4.0*
fi

if [ "${no_hadoop_2_4_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.4.1*
fi
if [ "${no_hadoop_2_5_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.5.0*
fi

if [ "${no_hadoop_2_5_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.5.1*
fi

if [ "${no_hadoop_2_5_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.5.2*
fi

if [ "${no_hadoop_2_6_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.0*
fi

if [ "${no_hadoop_2_6_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.1*
fi

if [ "${no_hadoop_2_7_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.7.0*
fi

if [ "${no_hadoop_2_7_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.7.1*
fi

if [ "${no_pig_0_12_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.12.0*
fi

if [ "${no_pig_0_12_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.12.1*
fi

if [ "${no_pig_0_13_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.13.0*
fi

if [ "${no_pig_0_14_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.14.0*
fi

if [ "${no_pig_0_15_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.15.0*
fi

if [ "${no_mahout_0_11_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*mahout-0.11.0*
fi

if [ "${no_mahout_0_11_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*mahout-0.11.1*
fi

if [ "${no_hbase_0_98_3_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.98.3-bin-hadoop2*
fi

if [ "${no_hbase_0_98_9_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.98.9-bin-hadoop2*
fi

if [ "${no_hbase_0_99_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.0*
fi

if [ "${no_hbase_0_99_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.1*
fi

if [ "${no_hbase_0_99_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.2*
fi

if [ "${no_hbase_1_0_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.0*
fi

if [ "${no_hbase_1_0_0_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.0.1*
fi

if [ "${no_hbase_1_0_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.1*
fi

if [ "${no_hbase_1_0_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.0.2*
fi

if [ "${no_hbase_1_1_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.0*
fi

if [ "${no_hbase_1_1_0_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.0.1*
fi

if [ "${no_hbase_1_1_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.1*
fi

if [ "${no_hbase_1_1_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.2*
fi

if [ "${no_phoenix_4_5_1_HBase_1_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.5.1-HBase-1.1*
fi

if [ "${no_phoenix_4_5_2_HBase_1_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.5.2-HBase-1.1*
fi

if [ "${no_phoenix_4_6_0_HBase_1_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*phoenix-4.6.0-HBase-1.1*
fi

if [ "${no_spark_0_9_1_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.1-bin-hadoop2*
fi

if [ "${no_spark_0_9_2_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.2-bin-hadoop2*
fi

if [ "${no_spark_1_2_0_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.0-bin-hadoop2.4*
fi

if [ "${no_spark_1_2_1_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.1-bin-hadoop2.4*
fi

if [ "${no_spark_1_2_2_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.2-bin-hadoop2.4*
fi

if [ "${no_spark_1_3_0_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.0-bin-hadoop2.4*
fi

if [ "${no_spark_1_3_1_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.1-bin-hadoop2.4*
fi

if [ "${no_spark_1_4_0_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.0-bin-hadoop2.6*
fi

if [ "${no_spark_1_4_1_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.1-bin-hadoop2.6*
fi

if [ "${no_spark_1_5_0_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.0-bin-hadoop2.6*
fi

if [ "${no_spark_1_5_1_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.1-bin-hadoop2.6*
fi

if [ "${no_spark_1_5_2_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.2-bin-hadoop2.6*
fi

if [ "${no_storm_0_9_3}" == "y" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.3*
fi

if [ "${no_storm_0_9_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.4*
fi

if [ "${no_storm_0_9_5}" == "y" ]
then
    rm -f magpie.${submissiontype}*storm-0.9.5*
fi

if [ "${no_zookeeper_3_4_5}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.5*
fi

if [ "${no_zookeeper_3_4_5}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.5*
fi

if [ "${no_zookeeper_3_4_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.0*
fi

if [ "${no_zookeeper_3_4_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.1*
fi

if [ "${no_zookeeper_3_4_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.2*
fi

if [ "${no_zookeeper_3_4_3}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.3*
fi

if [ "${no_zookeeper_3_4_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.4*
fi

if [ "${no_zookeeper_3_4_5}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.5*
fi

if [ "${no_zookeeper_3_4_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.6*
fi
