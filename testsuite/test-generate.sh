#!/bin/bash

# XXX - haven't handled msub-torque-pdsh yet

source test-generate-cornercase.sh
source test-generate-default.sh
source test-generate-functionality.sh
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
source test-common.sh
source test-config.sh

# Toggle y/n for different test types

# High Level, what tests to generate
# - these control if tests are created in sub-sections, like in
#   default, functionailty, and/or cornercase
# - magpietests covers "core" tests, most notably 'testall' and very corner case checks
# - standardtests: basic tests, terasort, sparkpi, etc.
# - dependencytests: check dependencies (e.g. store in hdfs, another job can read it)
# - specific sections can be configured below
# - specific versions can be configured below

magpietests=y
standardtests=y
dependencytests=y
hadooptests=y
pigtests=y
mahouttests=y
hbasetests=y
phoenixtests=y
sparktests=y
stormtests=y
kafkatests=y
zookeepertests=y

# Sections to test
# - version tests, test permutation of versions 
# These determine if specific sections will generate tests
defaulttests=y
cornercasetests=y
functionalitytests=y
hadoopversiontests=y
pigversiontests=y
mahoutversiontests=y
hbaseversiontests=y
phoenixversiontests=y
sparkversiontests=y
stormversiontests=y
kafkaversiontests=y
zookeeperversiontests=y

# Add or eliminate certain types of tests
#
# local_drive_tests - anything that uses a local drive (HDFS on disk, zookeeper local, etc.)
# hdfsoverlustre_tests - anything that uses hdfs over lustre
# hdfsovernetworkfs_tests - anything that uses hdfs over networkfs 
# rawnetworkfs_tests - anything that uses rawnetworkfs
# zookeepershared_tests - tests in which zookeeper shares nodes w/ compute/data nodes
# nolocaldirtests - using MAGPIE_NO_LOCAL_DIR
local_drive_tests=y
hdfsoverlustre_tests=y
hdfsovernetworkfs_tests=y
rawnetworkfs_tests=y
zookeepershared_tests=y
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
pig_0_13_0=y
pig_0_14_0=y
pig_0_15_0=y
pig_0_16_0=y
mahout_0_11_0=y
mahout_0_11_1=y
mahout_0_11_2=y
mahout_0_12_0=y
mahout_0_12_1=y
mahout_0_12_2=y
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
hbase_1_2_2=y
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
spark_1_6_2_bin_hadoop2_6=y
spark_2_0_0_bin_hadoop2_6=y
spark_2_0_0_bin_hadoop2_7=y
storm_0_9_3=y
storm_0_9_4=y
storm_0_9_5=y
storm_0_9_6=y
storm_0_10_0=y
storm_0_10_1=y
storm_1_0_0=y
storm_1_0_1=y
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

homedirpathsubst=`echo ${HOME_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/HOME_DIR_PREFIX=\(.*\)/HOME_DIR_PREFIX=${homedirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

lustredirpathsubst=`echo ${LUSTRE_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/LUSTRE_DIR_PREFIX=\(.*\)/LUSTRE_DIR_PREFIX=${lustredirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

networkfsdirpathsubst=`echo ${NETWORKFS_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/NETWORKFS_DIR_PREFIX=\(.*\)/NETWORKFS_DIR_PREFIX=${networkfsdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

rawnetworkfsdirpathsubst=`echo ${RAWNETWORKFS_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/RAWNETWORKFS_DIR_PREFIX=\(.*\)/RAWNETWORKFS_DIR_PREFIX=${rawnetworkfsdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

zookeeperdatadirpathsubst=`echo ${ZOOKEEPER_DATA_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/ZOOKEEPER_DATA_DIR_PREFIX=\(.*\)/ZOOKEEPER_DATA_DIR_PREFIX=${zookeeperdatadirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

ssddirpathsubst=`echo ${SSD_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/SSD_DIR_PREFIX=\(.*\)/SSD_DIR_PREFIX=${ssddirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/REMOTE_CMD_DEFAULT=ssh/REMOTE_CMD_DEFAULT=${REMOTE_CMD}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/MAGPIE_NO_LOCAL_DIR=n/MAGPIE_NO_LOCAL_DIR=y/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

projectdirpathsubst=`echo ${PROJECT_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/PROJECT_DIR_PREFIX=\(.*\)/PROJECT_DIR_PREFIX=${projectdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

if [ "${HADOOP_DIR_PATH}X" != "X" ]
then
    hadoopdirpathsubst=`echo ${HADOOP_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/HADOOP_DIR_PREFIX=\(.*\)/HADOOP_DIR_PREFIX=${hadoopdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${HBASE_DIR_PATH}X" != "X" ]
then
    hbasedirpathsubst=`echo ${HBASE_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/HBASE_DIR_PREFIX=\(.*\)/HBASE_DIR_PREFIX=${hbasedirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${KAFKA_DIR_PATH}X" != "X" ]
then
    kafkadirpathsubst=`echo ${KAFKA_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/KAFKA_DIR_PREFIX=\(.*\)/KAFKA_DIR_PREFIX=${kafkadirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${MAHOUT_DIR_PATH}X" != "X" ]
then
    mahoutdirpathsubst=`echo ${MAHOUT_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/MAHOUT_DIR_PREFIX=\(.*\)/MAHOUT_DIR_PREFIX=${mahoutdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${PHOENIX_DIR_PATH}X" != "X" ]
then
    phoenixdirpathsubst=`echo ${PHOENIX_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/PHOENIX_DIR_PREFIX=\(.*\)/PHOENIX_DIR_PREFIX=${phoenixdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${PIG_DIR_PATH}X" != "X" ]
then
    pigdirpathsubst=`echo ${PIG_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/PIG_DIR_PREFIX=\(.*\)/PIG_DIR_PREFIX=${pigdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${SPARK_DIR_PATH}X" != "X" ]
then
    sparkdirpathsubst=`echo ${SPARK_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/SPARK_DIR_PREFIX=\(.*\)/SPARK_DIR_PREFIX=${sparkdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${STORM_DIR_PATH}X" != "X" ]
then
    stormdirpathsubst=`echo ${STORM_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/STORM_DIR_PREFIX=\(.*\)/STORM_DIR_PREFIX=${stormdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

if [ "${ZOOKEEPER_DIR_PATH}X" != "X" ]
then
    zookeeperdirpathsubst=`echo ${ZOOKEEPER_DIR_PATH} | sed "s/\\//\\\\\\\\\//g"`
    sed -i -e "s/ZOOKEEPER_DIR_PREFIX=\(.*\)/ZOOKEEPER_DIR_PREFIX=${zookeeperdirpathsubst}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
fi

defaultlocalreqpathsubstr=`echo ${DEFAULT_LOCAL_REQUIREMENTS_FILE} | sed "s/\\//\\\\\\\\\//g"`
sed -i -e "s/LOCAL_REQUIREMENTS=n/LOCAL_REQUIREMENTS=${DEFAULT_LOCAL_REQUIREMENTS}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/LOCAL_REQUIREMENTS_FILE=\(.*\)/LOCAL_REQUIREMENTS_FILE=${defaultlocalreqpathsubstr}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

sed -i -e "s/HADOOP_FILESYSTEM_MODE=\"\(.*\)\"/HADOOP_FILESYSTEM_MODE=\"${DEFAULT_HADOOP_FILESYSTEM_MODE}\"/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile
sed -i -e "s/ZOOKEEPER_REPLICATION_COUNT=\(.*\)/ZOOKEEPER_REPLICATION_COUNT=${zookeepernodecount}/" ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

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

if [ "${submissiontype}" == "sbatch-srun" ]
then
    timestringtoreplace="<my time in minutes>"
    functiontogettimeoutput="GetMinutesJob"
elif [ "${submissiontype}" == "msub-slurm-srun" ]
then
    timestringtoreplace="<my time in seconds or HH:MM:SS>"
    functiontogettimeoutput="GetSecondsJob"
elif [ "${submissiontype}" == "lsf-mpirun" ]
then
    timestringtoreplace="<my time in hours:minutes>"
    functiontogettimeoutput="GetHoursMinutesJob"
fi

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

echo "Making launching scripts"

make ${submissiontype} &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/

if [ "${defaulttests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateDefaultStandardTests
    fi
fi

if [ "${functionalitytests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateFunctionalityTests
    fi
fi

if [ "${cornercasetests}" == "y" ]; then
    GenerateCornerCaseTests
fi

if [ "${hadooptests}" == "y" ] && [ "${hadoopversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateHadoopStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GenerateHadoopDependencyTests
    fi
fi
if [ "${pigtests}" == "y" ] && [ "${pigversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GeneratePigStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GeneratePigDependencyTests
    fi
fi
if [ "${mahouttests}" == "y" ] && [ "${mahoutversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateMahoutStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GenerateMahoutDependencyTests
    fi
fi
if [ "${hbasetests}" == "y" ] && [ "${hbaseversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateHbaseStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GenerateHbaseDependencyTests
    fi
fi
if [ "${phoenixtests}" == "y" ] && [ "${phoenixversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GeneratePhoenixStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GeneratePhoenixDependencyTests
    fi
fi
if [ "${sparktests}" == "y" ] && [ "${sparkversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateSparkStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GenerateSparkDependencyTests
    fi
fi
if [ "${stormtests}" == "y" ] && [ "${stormversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateStormStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GenerateStormDependencyTests
    fi
fi
if [ "${kafkatests}" == "y" ] && [ "${kafkaversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateKafkaStandardTests
    fi
    if [ "${dependencytests}" == "y" ]; then
        GenerateKafkaDependencyTests
    fi
fi
if [ "${zookeepertests}" == "y" ] && [ "${zookeeperversiontests}" == "y" ]; then
    if [ "${standardtests}" == "y" ]; then
        GenerateZookeeperStandardTests
    fi
fi

# Remove any tests we don't want

echo "Removing tests we do not want"

if [ "${local_drive_tests}" == "n" ]
then
    rm -f magpie.${submissiontype}-hadoop*hdfsondisk*
    rm -f magpie.${submissiontype}-hadoop*localstore*
    rm -f magpie.${submissiontype}-spark*localscratch*
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

if [ "${rawnetworkfs_tests}" == "n" ]
then
    rm -f magpie.${submissiontype}-*rawnetworkfs*
fi

if [ "${zookeepershared_tests}" == "n" ]
then
    rm -f magpie.${submissiontype}-*zookeeper-shared*
fi

if [ "${nolocaldirtests}" == "n" ]
then
    rm -f magpie.${submissiontype}*no-local-dir*
fi

for project in hadoop pig mahout hbase phoenix spark storm kafka zookeeper
do
    versionsvariable="${project}_all_versions"
    for version in ${!versionsvariable}
    do
        RemoveTestsCheck ${project} ${version}
    done
done    

# No if checks, may process files created outside of these files
# e.g. like functionality tests of default tests
GenerateHadoopPostProcessing
GeneratePigPostProcessing
GenerateMahoutPostProcessing
GenerateHbasePostProcessing
GeneratePhoenixPostProcessing
GenerateSparkPostProcessing
GenerateStormPostProcessing
GenerateKafkaPostProcessing
GenerateZookeeperPostProcessing

# Seds for all tests

echo "Finishing up test creation"

# Names important, will be used in validation

files=`find . -maxdepth 1 -name "magpie.${submissiontype}*Dependency*"`
if [ -n "${files}" ]
then
    sed -i -e "s/FILENAMESEARCHREPLACEKEY/Dependency-FILENAMESEARCHREPLACEKEY/" ${files}
fi

files=`find . -maxdepth 1 -name "magpie.${submissiontype}*no-local-dir*"`
if [ -n "${files}" ]
then
    sed -i -e 's/# export MAGPIE_NO_LOCAL_DIR="yes"/export MAGPIE_NO_LOCAL_DIR="yes"/' ${files}
fi

files=`find . -maxdepth 1 -name "magpie.${submissiontype}*"`
if [ -n "${files}" ]
then
    sed -i -e "s/<my node count>/${basenodescount}/" ${files}

    sed -i -e "s/<my job name>/test/" ${files}

    sed -i -e 's/# export MAGPIE_POST_JOB_RUN="\(.*\)"/export MAGPIE_POST_JOB_RUN="'"${magpiescriptshomesubst}"'\/scripts\/post-job-run-scripts\/magpie-gather-config-files-and-logs-script.sh"/' ${files}

    dependencyprefix=`date +"%Y%m%d%N"`

    sed -i -e "s/DEPENDENCYPREFIX/${dependencyprefix}/" ${files}

    sed -i -e 's/# export MAGPIE_STARTUP_TIME=.*/export MAGPIE_STARTUP_TIME='"${STARTUP_TIME}"'/' ${files}
    sed -i -e 's/# export MAGPIE_SHUTDOWN_TIME=.*/export MAGPIE_SHUTDOWN_TIME='"${SHUTDOWN_TIME}"'/' ${files}

    # Guarantee atleast 30 mins for all remaining jobs
    ${functiontogettimeoutput} 30
    sed -i -e "s/${timestringtoreplace}/${timeoutputforjob}/" ${files}

    if [ "${submissiontype}" == "sbatch-srun" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEPREFIX/slurm/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/%j/" ${files}
        
        sed -i -e "s/<my partition>/${sbatchsrunpartition}/" ${files}
    elif [ "${submissiontype}" == "msub-slurm-srun" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEPREFIX/moab/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/%j/" ${files}
        
        sed -i -e "s/<my partition>/${msubslurmsrunpartition}/" ${files}
        sed -i -e "s/<my batch queue>/${msubslurmsrunbatchqueue}/" ${files}
    elif [ "${submissiontype}" == "lsf-mpirun" ]
    then
        sed -i -e "s/FILENAMESEARCHREPLACEPREFIX/lsf/" ${files}
        sed -i -e "s/FILENAMESEARCHREPLACEKEY/%J/" ${files}
        
        sed -i -e "s/<my queue>/${lsfqueue}/" ${files}
    fi
fi

echo "Setting original submission scripts back to prior default"

cp ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile

rm -f ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/Makefile.testsuite-save

cd ${MAGPIE_SCRIPTS_HOME}/submission-scripts/script-templates/

make ${submissiontype} &> /dev/null

cd ${MAGPIE_SCRIPTS_HOME}/testsuite/
