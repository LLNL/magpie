#!/bin/sh

# Which tests to generate
#
# Presently supports
#
# Hadoop 2.2.0, 2.3.0, 2.4.0, 2.4.1, 2.5.0, 2.5.1, 2.5.2, 2.6.0,
# 2.6.1, 2.6.2, 2.6.3, 2.6.4, 2.7.0, 2.7.1, 2.7.2
# Pig 0.12.0, 0.12.1, 0.13.0, 0.14.0, 0.15.0
# Mahout 0.11.0, 0.11.1, 0.11.2
# Hbase 0.98.3-bin-hadoop2, 0.98.9-bin-hadoop2, 0.99.0, 0.99.1,
#   0.99.2, 1.0.0, 1.0.1, 1.0.1.1, 1.0.2, 1.1.0, 1.1.0.1, 1.1.1, 1.1.2,
#   1.1.3, 1.1.4, 1.2.0
# Phoenix 4.5.1-Hbase-1.1, 4.5.2-HBase-1.1, 4.6.0-HBase-1.1
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
# XXX - haven't handled msub-slurm-srun, or msub-torque-pdsh yet

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

# Higher level configuration, add or eliminate certain types of tests
#
# local_drive_tests - anything that uses a local drive (HDFS on disk, zookeeper local, etc.)
# hdfsoverlustre_tests - anything that uses hdfs over lustre
# hdfsovernetworkfs_tests - anything that uses hdfs over networkfs 
# largeperformanceruntests - run performance tests
# nolocaldirtests - using MAGPIE_NO_LOCAL_DIR
local_drive_tests=y
hdfsoverlustre_tests=y
hdfsovernetworkfs_tests=y
largeperformanceruntests=n
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
phoenix_4_5_1_HBase_1_1=y
phoenix_4_5_2_HBase_1_1=y
phoenix_4_6_0_HBase_1_1=y
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

java16pathsubst=`echo ${JAVA16PATH} | sed "s/\\//\\\\\\\\\//g"`
java17pathsubst=`echo ${JAVA17PATH} | sed "s/\\//\\\\\\\\\//g"`

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

echo "Making launching scripts"

make &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

GenerateDefaultStandardTests
GenerateHadoopStandardTests
GeneratePigStandardTests
GenerateMahoutStandardTests
GenerateHbaseStandardTests
GeneratePhoenixStandardTests
GenerateSparkStandardTests
GenerateStormStandardTests
GenerateKafkaStandardTests
GenerateZookeeperStandardTests

GenerateHadoopDependencyTests
GeneratePigDependencyTests
GenerateMahoutDependencyTests
GenerateHbaseDependencyTests
GeneratePhoenixDependencyTests
GenerateSparkDependencyTests
GenerateStormDependencyTests
GenerateKafkaDependencyTests

GenerateDefaultRegressionTests

# Seds for all tests

echo "Finishing up test creation"

# Names important, will be used in validation

if [ "${submissiontype}" == "sbatch-srun" ]
then
    sed -i -e "s/slurm-%j.out/slurm-run-hadoopterasort-%j.out/" magpie.${submissiontype}*run-hadoopterasort*
    sed -i -e "s/slurm-run-hadoopterasort-%j.out/slurm-run-hadoopterasort-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-hadoopterasort*

    sed -i -e "s/slurm-%j.out/slurm-run-scriptteragen-%j.out/" magpie.${submissiontype}-hadoop*run-scriptteragen
    sed -i -e "s/slurm-%j.out/slurm-run-scriptterasort-%j.out/" magpie.${submissiontype}-hadoop*run-scriptterasort
    sed -i -e "s/slurm-run-scriptteragen-%j.out/slurm-run-scriptteragen-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scriptteragen
    sed -i -e "s/slurm-run-scriptterasort-%j.out/slurm-run-scriptterasort-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scriptterasort

    sed -i -e "s/slurm-%j.out/slurm-run-hadoopupgradehdfs-%j.out/" magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs

    sed -i -e "s/slurm-%j.out/slurm-hdfs-fewer-nodes-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-fewer-nodes*expected-failure
    sed -i -e "s/slurm-%j.out/slurm-hdfs-older-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-older-version*expected-failure
    sed -i -e "s/slurm-%j.out/slurm-hdfs-newer-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-newer-version*expected-failure

    sed -i -e "s/slurm-%j.out/slurm-hdfs-more-nodes-decommissionhdfsnodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*decommissionhdfsnodes*

    sed -i -e "s/slurm-%j.out/slurm-run-testpig-%j.out/" magpie.${submissiontype}*run-testpig*
    sed -i -e "s/slurm-%j.out/slurm-run-pigscript-%j.out/" magpie.${submissiontype}*run-pigscript*

    sed -i -e "s/slurm-%j.out/slurm-run-clustersyntheticcontrol-%j.out/" magpie.${submissiontype}*run-clustersyntheticcontrol*

    sed -i -e "s/slurm-%j.out/slurm-run-hbaseperformanceeval-%j.out/" magpie.${submissiontype}*run-hbaseperformanceeval*
    sed -i -e "s/slurm-run-hbaseperformanceeval-%j.out/slurm-run-hbaseperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-hbaseperformanceeval*

    sed -i -e "s/slurm-%j.out/slurm-run-scripthbasewritedata-%j.out/" magpie.${submissiontype}*run-scripthbasewritedata*
    sed -i -e "s/slurm-%j.out/slurm-run-scripthbasereaddata-%j.out/" magpie.${submissiontype}*run-scripthbasereaddata*
    sed -i -e "s/slurm-run-scripthbasereaddata-%j.out/slurm-run-scripthbasereaddata-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scripthbasereaddata*

    sed -i -e "s/slurm-%j.out/slurm-run-phoenixperformanceeval-%j.out/" magpie.${submissiontype}*run-phoenixperformanceeval*
    sed -i -e "s/slurm-run-phoenixperformanceeval-%j.out/slurm-run-phoenixperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-phoenixperformanceeval*

    sed -i -e "s/slurm-%j.out/slurm-run-sparkpi-%j.out/" magpie.${submissiontype}*run-sparkpi*
    sed -i -e "s/slurm-%j.out/slurm-run-sparkwordcount-%j.out/" magpie.${submissiontype}*run-sparkwordcount*
    sed -i -e "s/slurm-%j.out/slurm-run-pysparkwordcount-%j.out/" magpie.${submissiontype}*run-pysparkwordcount*
    sed -i -e "s/slurm-run-sparkwordcount-%j.out/slurm-run-sparkwordcount-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-sparkwordcount*

    sed -i -e "s/slurm-run-sparkwordcount-%j.out/slurm-run-sparkwordcount-rawnetworkfs-%j.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*run-sparkwordcount*
    sed -i -e "s/slurm-run-sparkwordcount-%j.out/slurm-run-sparkwordcount-rawnetworkfs-more-nodes-%j.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*rawnetworkfs-more-nodes*run-sparkwordcount*
    
    sed -i -e "s/slurm-%j.out/slurm-run-stormwordcount-%j.out/" magpie.${submissiontype}*run-stormwordcount*
    sed -i -e "s/slurm-run-stormwordcount-%j.out/slurm-run-stormwordcount-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-stormwordcount*
    sed -i -e "s/slurm-%j.out/slurm-run-kafkaperformance-%j.out/" magpie.${submissiontype}*run-kafkaperformance*
    
    sed -i -e "s/slurm-%j.out/slurm-run-zookeeperruok-%j.out/" magpie.${submissiontype}*run-zookeeperruok*
    
    sed -i -e "s/-%j.out/-Dependency-%j.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in minutes>/300/" magpie.${submissiontype}-*largeperformancerun*
    sed -i -e "s/<my time in minutes>/90/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-storm* magpie.${submissiontype}-kafka* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in minutes>/120/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my partition>/${sbatchsrunpartition}/" magpie*
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    sed -i -e "s/moab-%j.out/moab-run-hadoopterasort-%j.out/" magpie.${submissiontype}*run-hadoopterasort*
    sed -i -e "s/moab-run-hadoopterasort-%j.out/moab-run-hadoopterasort-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-hadoopterasort*

    sed -i -e "s/moab-%j.out/moab-run-scriptteragen-%j.out/" magpie.${submissiontype}-hadoop*run-scriptteragen
    sed -i -e "s/moab-%j.out/moab-run-scriptterasort-%j.out/" magpie.${submissiontype}-hadoop*run-scriptterasort
    sed -i -e "s/moab-run-scriptteragen-%j.out/moab-run-scriptteragen-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scriptteragen
    sed -i -e "s/moab-run-scriptterasort-%j.out/moab-run-scriptterasort-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scriptterasort

    sed -i -e "s/moab-%j.out/moab-run-hadoopupgradehdfs-%j.out/" magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs

    sed -i -e "s/moab-%j.out/moab-hdfs-fewer-nodes-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-fewer-nodes*expected-failure
    sed -i -e "s/moab-%j.out/moab-hdfs-older-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-older-version*expected-failure
    sed -i -e "s/moab-%j.out/moab-hdfs-newer-version-expected-failure-%j.out/" magpie.${submissiontype}*hdfs-newer-version*expected-failure

    sed -i -e "s/moab-%j.out/moab-hdfs-more-nodes-decommissionhdfsnodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*decommissionhdfsnodes*
    
    sed -i -e "s/moab-%j.out/moab-run-testpig-%j.out/" magpie.${submissiontype}*run-testpig*
    sed -i -e "s/moab-%j.out/moab-run-pigscript-%j.out/" magpie.${submissiontype}*run-pigscript*

    sed -i -e "s/moab-%j.out/moab-run-clustersyntheticcontrol-%j.out/" magpie.${submissiontype}*run-clustersyntheticcontrol*

    sed -i -e "s/moab-%j.out/moab-run-hbaseperformanceeval-%j.out/" magpie.${submissiontype}*run-hbaseperformanceeval*
    sed -i -e "s/moab-run-hbaseperformanceeval-%j.out/moab-run-hbaseperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-hbaseperformanceeval*

    sed -i -e "s/moab-%j.out/moab-run-scripthbasewritedata-%j.out/" magpie.${submissiontype}*run-scripthbasewritedata*
    sed -i -e "s/moab-%j.out/moab-run-scripthbasereaddata-%j.out/" magpie.${submissiontype}*run-scripthbasereaddata*
    sed -i -e "s/moab-run-scripthbasereaddata-%j.out/moab-run-scripthbasereaddata-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scripthbasereaddata*

    sed -i -e "s/moab-%j.out/moab-run-phoenixperformanceeval-%j.out/" magpie.${submissiontype}*run-phoenixperformanceeval*
    sed -i -e "s/moab-run-phoenixperformanceeval-%j.out/moab-run-phoenixperformanceeval-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-phoenixperformanceeval*

    sed -i -e "s/moab-%j.out/moab-run-sparkpi-%j.out/" magpie.${submissiontype}*run-sparkpi*
    sed -i -e "s/moab-%j.out/moab-run-sparkwordcount-%j.out/" magpie.${submissiontype}*run-sparkwordcount*
    sed -i -e "s/moab-%j.out/moab-run-pysparkwordcount-%j.out/" magpie.${submissiontype}*run-pysparkwordcount*
    sed -i -e "s/moab-run-sparkwordcount-%j.out/moab-run-sparkwordcount-hdfs-more-nodes-%j.out/" magpie.${submissiontype}*hdfs-more-nodes*run-sparkwordcount*

    sed -i -e "s/moab-run-sparkwordcount-%j.out/moab-run-sparkwordcount-rawnetworkfs-%j.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*run-sparkwordcount*
    sed -i -e "s/moab-run-sparkwordcount-%j.out/moab-run-sparkwordcount-rawnetworkfs-more-nodes-%j.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*rawnetworkfs-more-nodes*run-sparkwordcount*

    sed -i -e "s/moab-%j.out/moab-run-stormwordcount-%j.out/" magpie.${submissiontype}*run-stormwordcount*
    sed -i -e "s/moab-run-stormwordcount-%j.out/moab-run-stormwordcount-zookeeper-shared-%j.out/" magpie.${submissiontype}*zookeeper-shared*run-stormwordcount*
    sed -i -e "s/moab-%j.out/moab-run-kafkaperformance-%j.out/" magpie.${submissiontype}*run-kafkaperformance*
    
    sed -i -e "s/moab-%j.out/moab-zookeeper-%j.out/" magpie.${submissiontype}-zookeeper*
    
    sed -i -e "s/-%j.out/-Dependency-%j.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in seconds or HH:MM:SS>/18000/" magpie.${submissiontype}-*largeperformancerun*
    sed -i -e "s/<my time in seconds or HH:MM:SS>/5400/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie-${submissiontype}-kafka* magpie.${submissiontype}-storm* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in seconds or HH:MM:SS>/7200/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my partition>/${msubslurmsrunpartition}/" magpie*
    sed -i -e "s/<my batch queue>/${msubslurmsrunbatchqueue}/" magpie*
elif [ "${submissiontype}" == "lsf-mpirun" ]
then
    sed -i -e "s/lsf-%J.out/lsf-run-hadoopterasort-%J.out/" magpie.${submissiontype}*run-hadoopterasort*
    sed -i -e "s/lsf-run-hadoopterasort-%J.out/lsf-run-hadoopterasort-hdfs-more-nodes-%J.out/" magpie.${submissiontype}*hdfs-more-nodes*run-hadoopterasort*

    sed -i -e "s/lsf-%J.out/lsf-run-scriptteragen-%J.out/" magpie.${submissiontype}-hadoop*run-scriptteragen
    sed -i -e "s/lsf-%J.out/lsf-run-scriptterasort-%J.out/" magpie.${submissiontype}-hadoop*run-scriptterasort
    sed -i -e "s/lsf-run-scriptteragen-%J.out/lsf-run-scriptteragen-hdfs-more-nodes-%J.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scriptteragen
    sed -i -e "s/lsf-run-scriptterasort-%J.out/lsf-run-scriptterasort-hdfs-more-nodes-%J.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scriptterasort

    sed -i -e "s/lsf-%J.out/lsf-run-hadoopupgradehdfs-%J.out/" magpie.${submissiontype}-hadoop*run-hadoopupgradehdfs

    sed -i -e "s/lsf-%J.out/lsf-hdfs-fewer-nodes-expected-failure-%J.out/" magpie.${submissiontype}*hdfs-fewer-nodes*expected-failure
    sed -i -e "s/lsf-%J.out/lsf-hdfs-older-version-expected-failure-%J.out/" magpie.${submissiontype}*hdfs-older-version*expected-failure
    sed -i -e "s/lsf-%J.out/lsf-hdfs-newer-version-expected-failure-%J.out/" magpie.${submissiontype}*hdfs-newer-version*expected-failure

    sed -i -e "s/lsf-%J.out/lsf-hdfs-more-nodes-decommissionhdfsnodes-%J.out/" magpie.${submissiontype}*hdfs-more-nodes*decommissionhdfsnodes*
    
    sed -i -e "s/lsf-%J.out/lsf-run-testpig-%J.out/" magpie.${submissiontype}*run-testpig*
    sed -i -e "s/lsf-%J.out/lsf-run-pigscript-%J.out/" magpie.${submissiontype}*run-pigscript*

    sed -i -e "s/lsf-%J.out/lsf-run-clustersyntheticcontrol-%J.out/" magpie.${submissiontype}*run-clustersyntheticcontrol*

    sed -i -e "s/lsf-%J.out/lsf-run-hbaseperformanceeval-%J.out/" magpie.${submissiontype}*run-hbaseperformanceeval*
    sed -i -e "s/lsf-run-hbaseperformanceeval-%J.out/lsf-run-hbaseperformanceeval-zookeeper-shared-%J.out/" magpie.${submissiontype}*zookeeper-shared*run-hbaseperformanceeval*

    sed -i -e "s/lsf-%J.out/lsf-run-scripthbasewritedata-%J.out/" magpie.${submissiontype}*run-scripthbasewritedata*
    sed -i -e "s/lsf-%J.out/lsf-run-scripthbasereaddata-%J.out/" magpie.${submissiontype}*run-scripthbasereaddata*
    sed -i -e "s/lsf-run-scripthbasereaddata-%J.out/lsf-run-scripthbasereaddata-hdfs-more-nodes-%J.out/" magpie.${submissiontype}*hdfs-more-nodes*run-scripthbasereaddata*

    sed -i -e "s/lsf-%J.out/lsf-run-phoenixperformanceeval-%J.out/" magpie.${submissiontype}*run-phoenixperformanceeval*
    sed -i -e "s/lsf-run-phoenixperformanceeval-%J.out/lsf-run-phoenixperformanceeval-zookeeper-shared-%J.out/" magpie.${submissiontype}*zookeeper-shared*run-phoenixperformanceeval*

    sed -i -e "s/lsf-%J.out/lsf-run-sparkpi-%J.out/" magpie.${submissiontype}*run-sparkpi*
    sed -i -e "s/lsf-%J.out/lsf-run-sparkwordcount-%J.out/" magpie.${submissiontype}*run-sparkwordcount*
    sed -i -e "s/lsf-%J.out/lsf-run-pysparkwordcount-%J.out/" magpie.${submissiontype}*run-pysparkwordcount*
    sed -i -e "s/lsf-run-sparkwordcount-%J.out/lsf-run-sparkwordcount-hdfs-more-nodes-%J.out/" magpie.${submissiontype}*hdfs-more-nodes*run-sparkwordcount*

    sed -i -e "s/lsf-run-sparkwordcount-%J.out/lsf-run-sparkwordcount-rawnetworkfs-%J.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*run-sparkwordcount*
    sed -i -e "s/lsf-run-sparkwordcount-%J.out/lsf-run-sparkwordcount-rawnetworkfs-more-nodes-%J.out/" magpie.${submissiontype}*spark-with-rawnetworkfs*rawnetworkfs-more-nodes*run-sparkwordcount*

    sed -i -e "s/lsf-%J.out/lsf-run-stormwordcount-%J.out/" magpie.${submissiontype}*run-stormwordcount*
    sed -i -e "s/lsf-run-stormwordcount-%J.out/lsf-run-stormwordcount-zookeeper-shared-%J.out/" magpie.${submissiontype}*zookeeper-shared*run-stormwordcount*
    sed -i -e "s/lsf-%J.out/lsf-run-kafkaperformance-%J.out/" magpie.${submissiontype}*run-kafkaperformance*
    
    sed -i -e "s/lsf-%J.out/lsf-run-zookeeper-%J.out/" magpie.${submissiontype}-zookeeper*
    
    sed -i -e "s/-%J.out/-Dependency-%J.out/" magpie.${submissiontype}*Dependency*

    sed -i -e "s/<my time in hours:minutes>/5:00/" magpie.${submissiontype}-*largeperformancerun*
    sed -i -e "s/<my time in hours:minutes>/1:30/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-kafka* magpie.${submissiontype}-storm* magpie.${submissiontype}-zookeeper*
    sed -i -e "s/<my time in hours:minutes>/2:00/" magpie.${submissiontype}-hbase-with-hdfs*

    sed -i -e "s/<my queue>/${lsfqueue}/" magpie*
fi
    
sed -i -e 's/# export MAGPIE_NO_LOCAL_DIR="yes"/export MAGPIE_NO_LOCAL_DIR="yes"/' magpie*no-local-dir
    
# special node sizes first
sed -i -e "s/<my node count>/20/" magpie.${submissiontype}-hbase-with-hdfs*hdfs-more-nodes*
sed -i -e "s/<my node count>/17/" magpie.${submissiontype}*hdfs-more-nodes*
sed -i -e "s/<my node count>/12/" magpie.${submissiontype}-hbase-with-hdfs*hdfs-fewer-nodes*
sed -i -e "s/<my node count>/9/" magpie.${submissiontype}*hdfs-fewer-nodes*
sed -i -e "s/<my node count>/9/" magpie.${submissiontype}-hadoop* magpie.${submissiontype}-spark* magpie.${submissiontype}-kafka*  magpie.${submissiontype}-zookeeper*
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

sed -i -e 's/# export MAGPIE_STARTUP_TIME=.*/export MAGPIE_STARTUP_TIME='"${STARTUP_TIME}"'/' magpie.${submissiontype}*
sed -i -e 's/# export MAGPIE_SHUTDOWN_TIME=.*/export MAGPIE_SHUTDOWN_TIME='"${SHUTDOWN_TIME}"'/' magpie.${submissiontype}*

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

if [ "${largeperformanceruntests}" == "n" ]
then
    rm -f magpie.${submissiontype}*largeperformancerun*
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

if [ "${spark_0_9_1_bin_hadoop2}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.1-bin-hadoop2*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-0.9.1-bin-hadoop2*
fi

if [ "${spark_0_9_2_bin_hadoop2}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-0.9.2-bin-hadoop2*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-0.9.2-bin-hadoop2*
fi

if [ "${spark_1_2_0_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.0-bin-hadoop2.4*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.2.0-bin-hadoop2.4*
fi

if [ "${spark_1_2_1_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.1-bin-hadoop2.4*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.2.1-bin-hadoop2.4*
fi

if [ "${spark_1_2_2_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.2.2-bin-hadoop2.4*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.2.2-bin-hadoop2.4*
fi

if [ "${spark_1_3_0_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.0-bin-hadoop2.4*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.3.0-bin-hadoop2.4*
fi

if [ "${spark_1_3_1_bin_hadoop2_4}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.3.1-bin-hadoop2.4*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.3.1-bin-hadoop2.4*
fi

if [ "${spark_1_4_0_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.0-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.4.0-bin-hadoop2.6*
fi

if [ "${spark_1_4_1_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.4.1-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.4.1-bin-hadoop2.6*
fi

if [ "${spark_1_5_0_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.0-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.5.0-bin-hadoop2.6*
fi

if [ "${spark_1_5_1_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.1-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.5.1-bin-hadoop2.6*
fi

if [ "${spark_1_5_2_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.5.2-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.5.2-bin-hadoop2.6*
fi

if [ "${spark_1_6_0_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.6.0-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.6.0-bin-hadoop2.6*
fi

if [ "${spark_1_6_1_bin_hadoop2_6}" == "n" ]
then
    rm -f magpie.${submissiontype}*spark-1.6.1-bin-hadoop2.6*
    rm -f magpie.${submissiontype}*spark-with-rawnetworkfs-1.6.1-bin-hadoop2.6*
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
