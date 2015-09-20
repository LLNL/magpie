#!/bin/sh

# Which tests to generate
#
# Presently supports
#
# Hadoop 2.4.0, 2.6.0, 2.7.1
# Pig 0.12.0, 0.14.0, 0.15.0
# Hbase 0.98.3-bin-hadoop2, 0.98.9-bin-hadoop2, 0.99.2, 1.1.1, 1.1.2
# Spark 0.9.1-bin-hadoop2, 1.2.0-bin-hadoop2.4, 1.3.0-bin-hadoop2.4, 1.4.1-bin-hadoop2.6, 1.5.1-bin-hadoop2.6
# Storm 0.9.3, 0.9.4, 0.9.5
# Zookeeper 3.4.5, 3.4.6
#
# Assumes network file system such as lustre is always available
#
# Assumes current defaults in Magpie are definitely available, but
# versions can be configured for which tests will run
#
# XXX - haven't handled lsf-mpirun, msub-slurm-srun, or msub-torque-pdsh yet

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

# Test config

no_local_ssd_tests=n
no_hadoop_2_4_0=n
no_hadoop_2_6_0=n
no_hadoop_2_7_1=n
no_pig_0_12_0=n
no_pig_0_14_0=n
no_pig_0_15_0=n
no_hbase_0_98_3_bin_hadoop2=n
no_hbase_0_98_9_bin_hadoop2=n
no_hbase_0_99_2=n
no_hbase_1_1_1=n
no_hbase_1_1_2=n
no_spark_0_9_1_bin_hadoop2=n
no_spark_1_2_0_bin_hadoop2_4=n
no_spark_1_3_0_bin_hadoop2_4=n
no_spark_1_4_1_bin_hadoop2_6=n
no_spark_1_5_0_bin_hadoop2_6=n
no_storm_0_9_3=n
no_storm_0_9_4=n
no_storm_0_9_5=n
no_zookeeper_3_4_5=n
no_zookeeper_3_4_6=n

# Configs for submission types

msubslurmsrunpartition=mycluster
msubslurmsrunbatchqueue=pbatch

sbatchsrunpartition=pc6220

# Configure Makefile 

# Remember to escape $ w/ \ if you want the environment variables
# placed into the submission scripts instead of being expanded out

LOCAL_DIR_PATH="/tmp/\${USER}"
PROJECT_DIR_PATH="\${HOME}/hadoop"
HOME_DIR_PATH="\${HOME}"
LUSTRE_DIR_PATH="/p/lscratchg/\${USER}/testing"
NETWORKFS_DIR_PATH="/p/lscratchg/\${USER}/testing"
SSD_DIR_PATH="/ssd/tmp1/\${USER}"

REMOTE_CMD=mrsh

MAGPIE_SCRIPTS_HOME=$(cd "`dirname "$0"`"/..; pwd)

if [ ! -d "${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates" ]
then
    echo "${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates not a directory"
    exit 1
fi

magpiescriptshomesubst=`echo ${MAGPIE_SCRIPTS_HOME} | sed "s/\\//\\\\\\\\\//g"`

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


cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

echo "Making launching scripts"

make &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

echo "Making default tests"

# Default Tests

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop .
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig .
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs .
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark .
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs .
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm .
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper

sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper
sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper
sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper

# Default No Local Dir Tests

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig magpie.${submissiontype}-hadoop-and-pig-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-no-local-dir
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-zookeeper-no-local-dir

sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-no-local-dir
sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-no-local-dir
sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-no-local-dir

# Dependency 1 tests, run different things after one another - Hadoop 2.4.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.4.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1A-hadoop-2.4.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.4.0-pig-0.14.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.14.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1A-hadoop-2.4.0-pig-0.14.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.9-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1A"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1A\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1A-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

# Dependency 1 tests, run different things after one another - Hadoop 2.6.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.6.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1B-hadoop-2.6.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.6.0-pig-0.14.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.14.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1B-hadoop-2.6.0-pig-0.14.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.9-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1B"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-hbase-0.98.9-hadoop2-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1B\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1B-hadoop-2.6.0-spark-1.3.0-bin-hadoop2.4

# Dependency 1 tests, run different things after one another - Hadoop 2.7.1

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.7.1

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-hadoop-DependencyGlobalOrder1C-hadoop-2.7.1

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.7.1-pig-0.15.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.15.0"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-hadoop-and-pig-DependencyGlobalOrder1C-hadoop-2.7.1-pig-0.15.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="1.1.2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/GlobalOrder1C"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-spark-1.5.0-bin-hadoop2.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/GlobalOrder1C\/"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.5.0-bin-hadoop2.6"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencyGlobalOrder1C-hadoop-2.7.1-spark-1.5.0-bin-hadoop2.6

# Hadoop Tests
# Note, b/c of MAPREDUCE-5528, not testing rawnetworkfs w/ terasort

echo "Making hadoop tests"

for hadoopversion in 2.7.1
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-no-local-dir

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*

    sed -i -e 's/# export HADOOP_TERASORT_SIZE=\(.*\)/export HADOOP_TERASORT_SIZE=10000000000/' magpie.${submissiontype}-hadoop-${hadoopversion}*largeperformancerun

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
done

for hadoopversion in 2.6.0 2.4.0
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-no-local-dir

    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-${hadoopversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/# export HADOOP_HDFS_PATH_CLEAR="yes"/export HADOOP_HDFS_PATH_CLEAR="yes"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk*

    sed -i -e 's/export HADOOP_HDFS_PATH="\(.*\)"/export HADOOP_HDFS_PATH="'"${ssddirpathsubst}"'\/a,'"${ssddirpathsubst}"'\/b,'"${ssddirpathsubst}"'\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre*
    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs*

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-no-local-dir

    sed -i -e 's/# export HADOOP_LOCALSTORE="\(.*\)"/export HADOOP_LOCALSTORE="'"${ssddirpathsubst}"'\/localstore\/a,'"${ssddirpathsubst}"'\/localstore\/b,'"${ssddirpathsubst}"'\/localstore\/c"/' magpie.${submissiontype}-hadoop-${hadoopversion}*localstore-multiple-paths*

    sed -i -e 's/# export HADOOP_TERASORT_SIZE=\(.*\)/export HADOOP_TERASORT_SIZE=10000000000/' magpie.${submissiontype}-hadoop-${hadoopversion}*largeperformancerun

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-hadoop-${hadoopversion}*
done

# Dependency Tests for Hadoop

# Dependency 1 Tests, run after another

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1AA-hadoop-2.4.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1AA\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-DependencyHadoop1AA-hadoop-2.4.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1AB-hadoop-2.6.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1AB\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-DependencyHadoop1AB-hadoop-2.6.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop ./magpie.${submissiontype}-hadoop-DependencyHadoop1AC-hadoop-2.7.1

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop1AC\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-DependencyHadoop1AC-hadoop-2.7.1

# Dependency 2 tests, upgrade hdfs, 2.4.0 -> 2.6.0 -> 2.7.1

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfs-older-version

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-upgradehdfs

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-upgradehdfs

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-hdfs-older-version

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-hdfs-older-version

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-upgradehdfs

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export HADOOP_MODE="terasort"/export HADOOP_MODE="upgradehdfs"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A-upgradehdfs

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop2A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop2A

# Dependency 3 test, increase size Hadoop 2.4.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A-hdfs-more-nodes
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A-hdfs-fewer-nodes

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop3A*

# Dependency 3 test, increase size Hadoop 2.6.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B-hdfs-more-nodes
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B-hdfs-fewer-nodes

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop3B*

# Dependency 3 test, increase size Hadoop 2.7.1

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C-hdfs-more-nodes
cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C-hdfs-fewer-nodes

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop3C\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop3C*

# Dependency 4 test, detect newer hdfs version 2.6.0 from 2.4.0, HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4A

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4A

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4A-hdfs-newer-version

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop4A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4A-hdfs-newer-version

# Dependency 4 test detect newer hdfs version 2.6.0 from 2.4.0, HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4B

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop4B

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4B-hdfs-newer-version

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop4B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop4B-hdfs-newer-version

# Dependency 5 test, detect newer hdfs version 2.7.1 from 2.6.0 HDFS over Lustre

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5A

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5A

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfs-newer-version

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsoverlustre"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hadoop5A\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfs-newer-version
 
# Dependency 5 test, detect newer hdfs version 2.7.1 from 2.6.0 HDFS over NetworkFS

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5B

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.7.1-DependencyHadoop5B

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5B-hdfs-newer-version

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="hdfsovernetworkfs"/' \
    -e 's/export HADOOP_HDFSOVERNETWORKFS_PATH="\(.*\)"/export HADOOP_HDFSOVERNETWORKFS_PATH="'"${networkfsdirpathsubst}"'\/hdfsovernetworkfs\/DEPENDENCYPREFIX\/Hadoop5B\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5B-hdfs-newer-version

# Pig Tests

echo "Making Pig tests"

for pigversion in 0.15.0
do
    for hadoopversion in 2.7.1
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*pig-script*

	sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/mytestpig.sh"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*pig-script*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    done
done

for pigversion in 0.14.0
do
    for hadoopversion in 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script-no-local-dir

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*pig-script*

	sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/mytestpig.sh"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*pig-script*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    done
done

for pigversion in 0.12.0 0.14.0
do
    for hadoopversion in 2.4.0 2.6.0
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-pig-script

	sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="'"${pigversion}"'"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*

	sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="script"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*pig-script*

	sed -i -e 's/# export MAGPIE_SCRIPT_PATH="\${HOME}\/my-job-script"/export MAGPIE_SCRIPT_PATH="'"${magpiescriptshomesubst}"'\/testsuite\/mytestpig.sh"/' ./magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*pig-script*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}*
    done
done

# Dependency 1 Tests, run after another

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AA-hadoop-2.4.0-pig-0.12.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.12.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Pig1AA\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AA-hadoop-2.4.0-pig-0.12.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AB-hadoop-2.6.0-pig-0.14.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.14.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Pig1AB\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AB-hadoop-2.6.0-pig-0.14.0

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hadoop-and-pig ./magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AC-hadoop-2.7.1-pig-0.15.0

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export PIG_VERSION="\(.*\)"/export PIG_VERSION="0.15.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Pig1AC\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-hadoop-and-pig-DependencyPig1AC-hadoop-2.7.1-pig-0.15.0

# Hbase Tests

echo "Making Hbase tests"

for hbaseversion in 0.99.2 1.1.1 1.1.2
do
    for hadoopversion in 2.7.1 
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local

	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local-no-local-dir
	    
	    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    
	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-thread*
	    
	    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	    
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	done
    done
done

for hbaseversion in 0.98.9-hadoop2
do
    for hadoopversion in 2.4.0 2.6.0 
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-networkfs-no-local-dir
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local-no-local-dir
	    
	    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    
	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-thread*
	    
	    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	    
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	done
    done
done

for hbaseversion in 0.98.3-hadoop2 0.98.9-hadoop2
do
    for hadoopversion in 2.4.0 2.6.0 
    do
	for zookeeperversion in 3.4.5 3.4.6
	do
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-networkfs
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-not-shared-zookeeper-local
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-zookeeper-networkfs-shared
	    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}-random-thread-zookeeper-shared-zookeeper-local
	    
	    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="'"${hadoopversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="'"${hbaseversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	    
	    sed -i -e 's/# export HBASE_PERFORMANCEEVAL_MODE="sequential-thread"/export HBASE_PERFORMANCEEVAL_MODE="random-thread"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*random-thread*
	    
	    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	    
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	    sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-hbase-with-hdfs-hadoop-${hadoopversion}-hbase-${hbaseversion}-zookeeper-${zookeeperversion}*
	done
    done
done

# Dependency 1 Tests, run after another

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AA-hadoop-2.6.0-hbase-0.98.3-bin-hadoop2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1AA\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.3-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1AA"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AA-hadoop-2.6.0-hbase-0.98.3-bin-hadoop2-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AB-hadoop-2.6.0-hbase-0.98.9-bin-hadoop2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1AB\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.98.9-hadoop2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1AB"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AB-hadoop-2.6.0-hbase-0.98.9-bin-hadoop2-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AC-hadoop-2.7.1-hbase-0.99.2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1AC\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="0.99.2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1AC"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AC-hadoop-2.7.1-hbase-0.99.2-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.1-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1AD\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="1.1.1"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1AD"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AD-hadoop-2.7.1-hbase-1.1.1-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-hbase-with-hdfs ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AE-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.7.1"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Hbase1AE\/"/' \
    -e 's/export HBASE_VERSION="\(.*\)"/export HBASE_VERSION="1.1.2"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Hbase1AE"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-hbase-with-hdfs-DependencyHbase1AE-hadoop-2.7.1-hbase-1.1.2-zookeeper-3.4.6

# Spark Tests

echo "Making Spark tests"

for sparkversion in 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-no-local-dir

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-spark-${sparkversion}*
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4 
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}-no-local-dir
    
    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-spark-${sparkversion}*
done

for sparkversion in 0.9.1-bin-hadoop2
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark magpie.${submissiontype}-spark-${sparkversion}

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-spark-${sparkversion}*
done

for sparkversion in 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0-no-local-dir

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0*

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.6.0*
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4 
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0-no-local-dir

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0*

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0*
done

for sparkversion in 0.9.1-bin-hadoop2
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0

    sed -i -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0*

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-spark-with-hdfs-${sparkversion}-hadoop-2.4.0*
done

for sparkversion in 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-no-local-dir

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*
done

for sparkversion in 1.2.0-bin-hadoop2.4 1.3.0-bin-hadoop2.4
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}-no-local-dir

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*
done

for sparkversion in 0.9.1-bin-hadoop2
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}

    sed -i -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="'"${sparkversion}"'"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

    sed -i -e 's/export HADOOP_FILESYSTEM_MODE="\(.*\)"/export HADOOP_FILESYSTEM_MODE="rawnetworkfs"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' ./magpie.${submissiontype}-spark-with-rawnetworkfs-${sparkversion}*
done

# Dependency 1 Tests, run after another

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AA-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1AA\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AA-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AB-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.4.0"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.3.0-bin-hadoop2.4"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1AB\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AB-hadoop-2.4.0-spark-1.3.0-bin-hadoop2.4

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.4.1-bin-hadoop2.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.4.1-bin-hadoop2.6"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1AC\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AC-hadoop-2.6.0-spark-1.4.1-bin-hadoop2.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-spark-with-hdfs ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AD-hadoop-2.6.0-spark-1.5.0-bin-hadoop2.6

sed -i \
    -e 's/export HADOOP_VERSION="\(.*\)"/export HADOOP_VERSION="2.6.0"/' \
    -e 's/export SPARK_VERSION="\(.*\)"/export SPARK_VERSION="1.5.0-bin-hadoop2.6"/' \
    -e 's/export HADOOP_HDFSOVERLUSTRE_PATH="\(.*\)"/export HADOOP_HDFSOVERLUSTRE_PATH="'"${lustredirpathsubst}"'\/hdfsoverlustre\/DEPENDENCYPREFIX\/Spark1AD\/"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    ./magpie.${submissiontype}-spark-with-hdfs-DependencySpark1AD-hadoop-2.6.0-spark-1.5.0-bin-hadoop2.6

# Storm Tests

echo "Making Storm tests"

for stormversion in 0.9.5
do
    for zookeeperversion in 3.4.5 3.4.6
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir

	sed -i -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*

	sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
	
	sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
    done
done

for stormversion in 0.9.3 0.9.4
do
    for zookeeperversion in 3.4.5 3.4.6
    do
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local

	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-networkfs-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-not-shared-zookeeper-local-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-networkfs-no-local-dir
	cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}-zookeeper-shared-zookeeper-local-no-local-dir

	sed -i -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="'"${stormversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*

	sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
	
	sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*

	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-networkfs*
	sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-local*
	
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=no/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-not-shared*
	sed -i -e 's/# export ZOOKEEPER_SHARE_NODES=yes/export ZOOKEEPER_SHARE_NODES=yes/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*zookeeper-shared*

	sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' magpie.${submissiontype}-storm-${stormversion}-zookeeper-${zookeeperversion}*
    done
done

# Dependency 1 Tests, run after another

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-storm-DependencyStorm1AA-storm-0.9.3-zookeeper-3.4.6

sed -i \
    -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="0.9.3"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Storm1AA"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-storm-DependencyStorm1AA-storm-0.9.3-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-storm-DependencyStorm1AB-storm-0.9.4-zookeeper-3.4.6

sed -i \
    -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="0.9.4"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Storm1AB"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.6.0-sun.x86_64\/"/' \
    magpie.${submissiontype}-storm-DependencyStorm1AB-storm-0.9.4-zookeeper-3.4.6

cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-storm-DependencyStorm1AC-storm-0.9.5-zookeeper-3.4.6

sed -i \
    -e 's/export STORM_VERSION="\(.*\)"/export STORM_VERSION="0.9.5"/' \
    -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="3.4.6"/' \
    -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${lustredirpathsubst}"'\/zookeeper\/DEPENDENCYPREFIX\/Storm1AC"/' \
    -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' \
    magpie.${submissiontype}-storm-DependencyStorm1AC-storm-0.9.5-zookeeper-3.4.6

# Zookeeper Tests
 
echo "Making Zookeeper tests"

for zookeeperversion in 3.4.5 3.4.6
do
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs-no-local-dir
    cp ../submission-scripts/script-${submissiontype}/magpie.${submissiontype}-storm ./magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local-no-local-dir

    sed -i -e 's/export MAGPIE_JOB_TYPE="\(.*\)"/export MAGPIE_JOB_TYPE="zookeeper"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export STORM_SETUP=yes/export STORM_SETUP=no/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_VERSION="\(.*\)"/export ZOOKEEPER_VERSION="'"${zookeeperversion}"'"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/export ZOOKEEPER_MODE="\(.*\)"/export ZOOKEEPER_MODE="zookeeperruok"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*

    sed -i -e 's/# export ZOOKEEPER_DATA_DIR_CLEAR="yes"/export ZOOKEEPER_DATA_DIR_CLEAR="yes"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local*

    sed -i -e 's/export ZOOKEEPER_DATA_DIR="\(.*\)"/export ZOOKEEPER_DATA_DIR="'"${ssddirpathsubst}"'\/zookeeper\/"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local* 

    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="networkfs"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-networkfs* 
    sed -i -e 's/export ZOOKEEPER_DATA_DIR_TYPE="\(.*\)"/export ZOOKEEPER_DATA_DIR_TYPE="local"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}-zookeeper-local* 

    sed -i -e 's/export JAVA_HOME="\(.*\)"/export JAVA_HOME="\/usr\/lib\/jvm\/jre-1.7.0-oracle.x86_64\/"/' magpie.${submissiontype}-zookeeper-${zookeeperversion}*
done

# Seds for all tests

echo "Finishing up test creation"

# Names important, will be used in validation

if [ "${submissiontype}" == "sbatch-srun" ]
then
    sed -i -e "s/slurm-%j.out/slurm-hadoop-terasort-%j.out/" magpie.${submissiontype}-hadoop*
    sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-upgradehdfs-%j.out/" magpie.${submissiontype}-hadoop*upgradehdfs
    sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-and-pig-%j.out/" magpie.${submissiontype}-hadoop-and-pig*
    sed -i -e "s/slurm-hadoop-and-pig-%j.out/slurm-hadoop-and-pig-pig-script-%j.out/" magpie.${submissiontype}-hadoop-and-pig*pig-script*
    sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-more-nodes-%j.out/" magpie.${submissiontype}-hadoop*hdfs-more-nodes
    sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-fewer-nodes-%j.out/" magpie.${submissiontype}-hadoop*hdfs-fewer-nodes
    sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-older-version-%j.out/" magpie.${submissiontype}-hadoop*hdfs-older-version
    sed -i -e "s/slurm-hadoop-terasort-%j.out/slurm-hadoop-hdfs-newer-version-%j.out/" magpie.${submissiontype}-hadoop*hdfs-newer-version
    
    sed -i -e "s/slurm-%j.out/slurm-hbase-%j.out/" magpie.${submissiontype}-hbase*
    sed -i -e "s/slurm-hbase-%j.out/slurm-hbase-zookeeper-shared-%j.out/" magpie.${submissiontype}-hbase*zookeeper*zookeeper-shared*
    
    sed -i -e "s/slurm-%j.out/slurm-spark-pi-%j.out/" magpie.${submissiontype}-spark*
    sed -i -e "s/slurm-spark-pi-%j.out/slurm-spark-wordcount-%j.out/" magpie.${submissiontype}-spark-with-hdfs*
    sed -i -e "s/slurm-spark-pi-%j.out/slurm-spark-wordcount-rawnetworkfs-%j.out/" magpie.${submissiontype}-spark-with-rawnetworkfs*
    
    sed -i -e "s/slurm-%j.out/slurm-storm-%j.out/" magpie.${submissiontype}-storm*
    sed -i -e "s/slurm-storm-%j.out/slurm-storm-zookeeper-shared-%j.out/" magpie.${submissiontype}-storm*zookeeper*zookeeper-shared*
    
    sed -i -e "s/slurm-%j.out/slurm-zookeeper-%j.out/" magpie.${submissiontype}-zookeeper*
    
    sed -i -e "s/-%j.out/-Dependency-%j.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in minutes>/300/" magpie.${submissiontype}-*largeperformancerun
    sed -i -e "s/<my time in minutes>/90/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-storm* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in minutes>/120/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my partition>/${sbatchsrunpartition}/" magpie*
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    sed -i -e "s/moab-%j.out/moab-hadoop-terasort-%j.out/" magpie.${submissiontype}-hadoop*
    sed -i -e "s/moab-hadoop-terasort-%j.out/moab-hadoop-upgradehdfs-%j.out/" magpie.${submissiontype}-hadoop*upgradehdfs
    sed -i -e "s/moab-hadoop-terasort-%j.out/moab-hadoop-and-pig-%j.out/" magpie.${submissiontype}-hadoop-and-pig*
    sed -i -e "s/moab-hadoop-and-pig-%j.out/moab-hadoop-and-pig-pig-script-%j.out/" magpie.${submissiontype}-hadoop-and-pig*pig-script*
    sed -i -e "s/moab-hadoop-terasort-%j.out/moab-hadoop-hdfs-more-nodes-%j.out/" magpie.${submissiontype}-hadoop*hdfs-more-nodes
    sed -i -e "s/moab-hadoop-terasort-%j.out/moab-hadoop-hdfs-fewer-nodes-%j.out/" magpie.${submissiontype}-hadoop*hdfs-fewer-nodes
    sed -i -e "s/moab-hadoop-terasort-%j.out/moab-hadoop-hdfs-older-version-%j.out/" magpie.${submissiontype}-hadoop*hdfs-older-version
    sed -i -e "s/moab-hadoop-terasort-%j.out/moab-hadoop-hdfs-newer-version-%j.out/" magpie.${submissiontype}-hadoop*hdfs-newer-version
    
    sed -i -e "s/moab-%j.out/moab-hbase-%j.out/" magpie.${submissiontype}-hbase*
    sed -i -e "s/moab-hbase-%j.out/moab-hbase-zookeeper-shared-%j.out/" magpie.${submissiontype}-hbase*zookeeper*zookeeper-shared*
    
    sed -i -e "s/moab-%j.out/moab-spark-pi-%j.out/" magpie.${submissiontype}-spark*
    sed -i -e "s/moab-spark-pi-%j.out/moab-spark-wordcount-%j.out/" magpie.${submissiontype}-spark-with-hdfs*
    sed -i -e "s/moab-spark-pi-%j.out/moab-spark-wordcount-rawnetworkfs-%j.out/" magpie.${submissiontype}-spark-with-rawnetworkfs*
    
    sed -i -e "s/moab-%j.out/moab-storm-%j.out/" magpie.${submissiontype}-storm*
    sed -i -e "s/moab-storm-%j.out/moab-storm-zookeeper-shared-%j.out/" magpie.${submissiontype}-storm*zookeeper*zookeeper-shared*
    
    sed -i -e "s/moab-%j.out/moab-zookeeper-%j.out/" magpie.${submissiontype}-zookeeper*
    
    sed -i -e "s/-%j.out/-Dependency-%j.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in seconds or HH:MM:SS>/18000/" magpie.${submissiontype}-*largeperformancerun
    sed -i -e "s/<my time in seconds or HH:MM:SS>/5400/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-storm* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in seconds or HH:MM:SS>/7200/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my partition>/${msubslurmsrunpartition}/" magpie*
    sed -i -e "s/<my batch queue>/${msubslurmsrunbatchqueue}/" magpie*
fi
    
sed -i -e 's/# export MAGPIE_NO_LOCAL_DIR="yes"/export MAGPIE_NO_LOCAL_DIR="yes"/' magpie*no-local-dir
    
# special node sizes first
sed -i -e "s/<my node count>/17/" magpie.${submissiontype}*more-nodes
sed -i -e "s/<my node count>/8/" magpie.${submissiontype}*hdfs-fewer-nodes
sed -i -e "s/<my node count>/9/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-zookeeper*
sed -i -e "s/<my node count>/12/" magpie.${submissiontype}-hbase-with-hdfs* magpie.${submissiontype}-storm* 

sed -i -e "s/<my job name>/test/" magpie*

sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.${submissiontype}-spark-with-hdfs*
sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*
sed -i -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-hdfs*

sed -i -e 's/export SPARK_MODE="sparkpi"/export SPARK_MODE="sparkwordcount"/' magpie.${submissiontype}-spark-with-rawnetworkfs*
sed -i -e 's/# export SPARK_SPARKWORDCOUNT_FILE=\"\/mywordcountfile\"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/mywordcountfile\"/' magpie.${submissiontype}-spark-with-rawnetworkfs*

ls magpie* | grep -v Dependency | xargs sed -i -e 's/# export HADOOP_PER_JOB_HDFS_PATH="yes"/export HADOOP_PER_JOB_HDFS_PATH="yes"/'
ls magpie* | grep -v Dependency | xargs sed -i -e 's/# export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/export ZOOKEEPER_PER_JOB_DATA_DIR="yes"/'

sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\${HOME}\/magpie-my-post-job-script"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' magpie*

dependencyprefix=`date +"%Y%m%d%N"`

sed -i -e "s/DEPENDENCYPREFIX/${dependencyprefix}/" magpie*

echo "Setting original submission scripts back to system default"

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

git checkout Makefile

make &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

if [ "${no_local_ssd_tests}" == "y" ]
then
    rm -f magpie.${submissiontype}-hadoop*hdfsondisk*
    rm -f magpie.${submissiontype}-hadoop*localstore*
    rm -f magpie.${submissiontype}-*zookeeper-local*
fi

if [ "${no_hadoop_2_4_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.4.0*
fi

if [ "${no_hadoop_2_6_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.6.0*
fi

if [ "${no_hadoop_2_7_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hadoop-2.7.1*
fi

if [ "${no_pig_0_12_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.12.0*
fi

if [ "${no_pig_0_14_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.14.0*
fi

if [ "${no_pig_0_15_0}" == "y" ]
then
    rm -f magpie.${submissiontype}*pig-0.15.0*
fi

if [ "${no_hbase_0_98_3_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.98.3-bin-hadoop2*
fi

if [ "${no_hbase_0_98_9_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.98.9-bin-hadoop2*
fi

if [ "${no_hbase_0_99_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-0.99.2*
fi

if [ "${no_hbase_1_1_1}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.1*
fi

if [ "${no_hbase_1_1_2}" == "y" ]
then
    rm -f magpie.${submissiontype}*hbase-1.1.2*
fi

if [ "${no_spark_0_9_1_bin_hadoop2}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.1-bin-hadoop2*
fi

if [ "${no_spark_1_2_0_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.0-bin-hadoop2.4*
fi

if [ "${no_spark_1_3_0_bin_hadoop2_4}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.0-bin-hadoop2.4*
fi

if [ "${no_spark_1_4_1_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.1-bin-hadoop2.6*
fi

if [ "${no_spark_1_5_0_bin_hadoop2_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.0-bin-hadoop2.6*
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

if [ "${no_zookeeper_3_4_6}" == "y" ]
then
    rm -f magpie.${submissiontype}*zookeeper-3.4.6*
fi
