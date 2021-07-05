# Creation options, set to y or n
#
# Note that Hbase requires Hadoop, Hbase & Storm require Zookeeper
#
# MAGPIE_NO_LOCAL_DIR - support MAGPIE_NO_LOCAL_DIR
#
# INSERT_HDFSOVERLUSTRE - insert HDFS over Lustre configuration
#
# INSERT_HDFSOVERNETWORKFS - insert HDFS over NetworkFS configuration
#
HADOOP_INCLUDE=y
PIG_INCLUDE=y
HBASE_INCLUDE=y
HIVE_INCLUDE=y
PHOENIX_INCLUDE=y
SPARK_INCLUDE=y
KAFKA_INCLUDE=y
STORM_INCLUDE=y
ZEPPELIN_INCLUDE=y
ZOOKEEPER_INCLUDE=y
TENSORFLOW_INCLUDE=y
TENSORFLOW_HOROVOD_INCLUDE=y
RAY_INCLUDE=y
ALLUXIO_INCLUDE=y

MAGPIE_NO_LOCAL_DIR=n
MAGPIE_HOSTNAME_MAP=n
INSERT_HDFSOVERLUSTRE=y
INSERT_HDFSOVERNETWORKFS=y

#
# Adjust any of these paths for your own local defaults
#
MAGPIE_SCRIPTS_DIR_PREFIX=$${HOME}
LOCAL_DIR_PREFIX=/tmp/$${USER}
HOME_DIR_PREFIX=$${HOME}
LUSTRE_DIR_PREFIX=/lustre/$${USER}
NETWORKFS_DIR_PREFIX=/networkfs/$${USER}
RAWNETWORKFS_DIR_PREFIX=/lustre/$${USER}
ZOOKEEPER_DATA_DIR_PREFIX=/lustre/$${USER}
LOCAL_DRIVE_PREFIX=/ssd/$${USER}

PROJECT_DIR_PREFIX=$${HOME}
HADOOP_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
HBASE_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
HIVE_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
POSTGRES_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
TESTBENCH_DIR_PREFIX=${PROJECT_DIR_PREFIX}
TEZ_DIR_PREFIX=${PROJECT_DIR_PREFIX}
KAFKA_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
PHOENIX_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
PIG_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
SPARK_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
STORM_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
ZEPPELIN_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
ZOOKEEPER_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
RAY_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
ALLUXIO_DIR_PREFIX=$(PROJECT_DIR_PREFIX)

REMOTE_CMD_DEFAULT=ssh

JAVA_DEFAULT=/usr/lib/jvm/jre-1.8.0/
HADOOP_JAVA_DEFAULT=/usr/lib/jvm/jre-1.8.0/
PIG_JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0/
HBASE_JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0/
PHOENIX_JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0/
SPARK_JAVA_DEFAULT=/usr/lib/jvm/jre-1.8.0/
STORM_JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0/
ZEPPELIN_JAVA_DEFAULT=/usr/lib/jvm/jre-1.8.0/
PYTHON_DEFAULT=/usr/bin/python3

#
# Misc defaults you may wish to set
#

HADOOP_FILESYSTEM_MODE="hdfsoverlustre"
ZOOKEEPER_REPLICATION_COUNT=3
HADOOP_DEFAULT_TERASORT_SIZE=50000000
HBASE_DEFAULT_PERFORMANCEEVAL_ROW_COUNT=1048576
PHOENIX_DEFAULT_PERFORMANCEEVAL_ROW_COUNT=100000

HIVE_DEFAULT_PORT=10000
POSTGRES_DEFAULT_PORT=11115
HIVE_DEFAULT_DB_NAME="hive_default_db"

#
# Adjust for default versions
#
HADOOP_VERSION_DEFAULT=3.3.1
PIG_VERSION_DEFAULT=0.17.0
PIG_HADOOP_VERSION_DEFAULT=2.9.1
HBASE_VERSION_DEFAULT=1.6.0
HBASE_HADOOP_VERSION_DEFAULT=2.9.1
HBASE_ZOOKEEPER_VERSION_DEFAULT=3.4.14
HIVE_VERSION_DEFAULT=2.3.0
HIVE_POSTGRESQL_VERSION_DEFAULT=9.6.3
HIVE_TEZ_VERSION_DEFAULT=0.9.1
PHOENIX_VERSION_DEFAULT=4.14.0-HBase-1.4
PHOENIX_HADOOP_VERSION_DEFAULT=2.9.1
PHOENIX_HBASE_VERSION_DEFAULT=1.6.0
PHOENIX_ZOOKEEPER_VERSION_DEFAULT=3.4.14
SPARK_VERSION_DEFAULT=3.0.3-bin-hadoop3.2
SPARK_HADOOP_VERSION_DEFAULT=3.2.2
KAFKA_VERSION_DEFAULT=2.11-0.9.0.0
STORM_VERSION_DEFAULT=1.2.3
STORM_ZOOKEEPER_VERSION_DEFAULT=3.4.14
ZOOKEEPER_VERSION_DEFAULT=3.4.14
ZEPPELIN_VERSION_DEFAULT=0.8.2
ZEPPELIN_SPARK_VERSION_DEFAULT=2.3.0-bin-hadoop2.7
ALLUXIO_VERSION_DEFAULT=2.3.0

#
# If LOCAL_REQUIREMENTS is set to 'y', whatever is in the file pointed
# by LOCAL_REQUIREMENTS_FILE will be added to submission scripts
# before the first call to magpie-check-inputs
#
LOCAL_REQUIREMENTS=n
LOCAL_REQUIREMENTS_FILE=/tmp/mylocal

# Default job files
SBATCH_MPIRUN_DEFAULT_JOB_FILE=slurm-%j.out
SBATCH_SRUN_DEFAULT_JOB_FILE=slurm-%j.out
MSUB_SLURM_SRUN_DEFAULT_JOB_FILE=moab-%j.out
MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE=moab-%j.out
LSF_MPIRUN_DEFAULT_JOB_FILE=lsf-%J.out

.DEFAULT_GOAL=all

all: msub-slurm-srun sbatch-srun msub-torque-pdsh lsf-mpirun sbatch-mpirun

clean-sbatch-srun:
	rm -f ../script-sbatch-srun/magpie.sbatch-srun*

clean-msub-slurm-srun:
	rm -f ../script-msub-slurm-srun/magpie.msub-slurm*

clean-msub-torque-pdsh:
	rm -f ../script-msub-torque-pdsh/magpie.msub-torque*

clean-lsf-mpirun:
	rm -f ../script-lsf-mpirun/magpie.lsf-mpirun*

clean-sbatch-mpirun:
	rm -f ../script-sbatch-mpirun/magpie.sbatch-mpirun*

clean: clean-sbatch-srun clean-msub-slurm-srun clean-msub-torque-pdsh clean-lsf-mpirun clean-sbatch-mpirun

sbatch-srun: clean-sbatch-srun
	$(call create-bigdata-templates,$@,srun,$(SBATCH_SRUN_DEFAULT_JOB_FILE))
	$(call create-ml-master-worker-templates,$@,srun,$(SBATCH_SRUN_DEFAULT_JOB_FILE))
	$(call create-tensorflow-templates,$@,srun,$(SBATCH_SRUN_DEFAULT_JOB_FILE))

msub-slurm-srun: clean-msub-slurm-srun
	$(call create-bigdata-templates,$@,srun,$(MSUB_SLURM_SRUN_DEFAULT_JOB_FILE))
	$(call create-ml-master-worker-templates,$@,srun,$(MSUB_SLURM_SRUN_DEFAULT_JOB_FILE))

msub-torque-pdsh: clean-msub-torque-pdsh
	$(call create-bigdata-templates,$@,pdsh,$(MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE))
	$(call create-ml-master-worker-templates,$@,pdsh,$(MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE))

lsf-mpirun: clean-lsf-mpirun
	$(call create-bigdata-templates,$@,mpirun,$(LSF_MPIRUN_DEFAULT_JOB_FILE))
	$(call create-ml-master-worker-templates,$@,mpirun,$(LSF_MPIRUN_DEFAULT_JOB_FILE))

sbatch-mpirun: clean-sbatch-mpirun
	$(call create-bigdata-templates,$@,mpirun,$(SBATCH_MPIRUN_DEFAULT_JOB_FILE))
	$(call create-ml-master-worker-templates,$@,mpirun,$(SBATCH_MPIRUN_DEFAULT_JOB_FILE))
	$(call create-tensorflow-templates,$@,mpirun,$(SBATCH_MPIRUN_DEFAULT_JOB_FILE))

define common-substitution
	sed -i -e 's;MAGPIESCRIPTSDIRPREFIX;$(MAGPIE_SCRIPTS_DIR_PREFIX);g' $(1)
	sed -i -e 's;LOCALDIRPREFIX;$(LOCAL_DIR_PREFIX);g' $(1)
	sed -i -e 's;HOMEDIRPREFIX;$(HOME_DIR_PREFIX);g' $(1)
	sed -i -e 's;LUSTREDIRPREFIX;$(LUSTRE_DIR_PREFIX);g' $(1)
	sed -i -e 's;NETWORKFSDIRPREFIX;$(NETWORKFS_DIR_PREFIX);g' $(1)
	sed -i -e 's;RAWFSDIRPREFIX;$(RAWNETWORKFS_DIR_PREFIX);g' $(1)
	sed -i -e 's;ZOOKEEPERDATADIRPREFIX;$(ZOOKEEPER_DATA_DIR_PREFIX);g' $(1)
	sed -i -e 's;LOCALDRIVEPREFIX;$(LOCAL_DRIVE_PREFIX);g' $(1)

	sed -i -e 's;HADOOPDIRPREFIX;$(HADOOP_DIR_PREFIX);g' $(1)
	sed -i -e 's;HBASEDIRPREFIX;$(HBASE_DIR_PREFIX);g' $(1)
	sed -i -e 's;HIVEDIRPREFIX;$(HIVE_DIR_PREFIX);g' $(1)
	sed -i -e 's;POSTGRESDIRPREFIX;$(POSTGRES_DIR_PREFIX);g' $(1)
	sed -i -e 's;TEZDIRPREFIX;${TEZ_DIR_PREFIX};g' $(1)
	sed -i -e 's;TESTBENCHDIRPREFIX;$(TESTBENCH_DIR_PREFIX);g' $(1)
	sed -i -e 's;KAFKADIRPREFIX;$(KAFKA_DIR_PREFIX);g' $(1)
	sed -i -e 's;PHOENIXDIRPREFIX;$(PHOENIX_DIR_PREFIX);g' $(1)
	sed -i -e 's;PIGDIRPREFIX;$(PIG_DIR_PREFIX);g' $(1)
	sed -i -e 's;SPARKDIRPREFIX;$(SPARK_DIR_PREFIX);g' $(1)
	sed -i -e 's;STORMDIRPREFIX;$(STORM_DIR_PREFIX);g' $(1)
	sed -i -e 's;ZEPPELINDIRPREFIX;$(ZEPPELIN_DIR_PREFIX);g' $(1)
	sed -i -e 's;ZOOKEEPERDIRPREFIX;$(ZOOKEEPER_DIR_PREFIX);g' $(1)
	sed -i -e 's;RAYDIRPREFIX;$(RAY_DIR_PREFIX);g' $(1)
	sed -i -e 's;ALLUXIODIRPREFIX;$(ALLUXIO_DIR_PREFIX);g' $(1)

	sed -i -e 's;HADOOPVERSIONDEFAULT;$(HADOOP_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;PIGVERSIONDEFAULT;$(PIG_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;HBASEVERSIONDEFAULT;$(HBASE_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;HIVEVERSIONDEFAULT;$(HIVE_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;HIVETEZVERSIONDEFAULT;$(HIVE_TEZ_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;PHOENIXVERSIONDEFAULT;$(PHOENIX_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;SPARKVERSIONDEFAULT;$(SPARK_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;KAFKAVERSIONDEFAULT;$(KAFKA_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;STORMVERSIONDEFAULT;$(STORM_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;ZOOKEEPERVERSIONDEFAULT;$(ZOOKEEPER_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;ZEPPELINVERSIONDEFAULT;$(ZEPPELIN_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;ALLUXIOVERSIONDEFAULT;$(ALLUXIO_VERSION_DEFAULT);g' $(1)

	sed -i -e 's;REMOTECMDDEFAULT;$(REMOTE_CMD_DEFAULT);g' $(1)
	if test "${REMOTE_CMD_DEFAULT}" != "ssh"; then \
		sed -i -e "s/^# export MAGPIE_REMOTE_CMD/export MAGPIE_REMOTE_CMD/g" $(1); \
	fi
	sed -i -e 's;JAVADEFAULT;$(2);g' $(1)
	sed -i -e 's;PYTHONDEFAULT;$(PYTHON_DEFAULT);g' $(1)
        sed -i -e 's;HADOOPFILESYSTEMMODE;$(HADOOP_FILESYSTEM_MODE);g' $(1)
	sed -i -e 's;ZOOKEEPERREPLICATIONCOUNT;$(ZOOKEEPER_REPLICATION_COUNT);g' $(1)
	sed -i -e 's;HADOOPDEFAULTTERASORTSIZE;$(HADOOP_DEFAULT_TERASORT_SIZE);g' $(1)
	if test "${HADOOP_DEFAULT_TERASORT_SIZE}" != "50000000"; then \
		sed -i -e "s/^# export HADOOP_TERASORT_SIZE/export HADOOP_TERASORT_SIZE/g" $(1); \
	fi
	sed -i -e 's;HBASEDEFAULTPERFORMANCEEVALROWCOUNT;$(HBASE_DEFAULT_PERFORMANCEEVAL_ROW_COUNT);g' $(1)
	if test "${HBASE_DEFAULT_PERFORMANCEEVAL_ROW_COUNT}" != "1048576"; then \
		sed -i -e "s/^# export HBASE_PERFORMANCEEVAL_ROW_COUNT/export HBASE_PERFORMANCEEVAL_ROW_COUNT/g" $(1); \
	fi
	sed -i -e 's;HIVEDEFAULTDBNAME;$(HIVE_DEFAULT_DB_NAME);g' $(1)
	sed -i -e 's;HIVEDEFAULTPORT;$(HIVE_DEFAULT_PORT);g' $(1)
	sed -i -e 's;POSTGRESDEFAULTPORT;$(POSTGRES_DEFAULT_PORT);g' $(1)

	sed -i -e 's;PHOENIXDEFAULTPERFORMANCEEVALROWCOUNT;$(PHOENIX_DEFAULT_PERFORMANCEEVAL_ROW_COUNT);g' $(1)
	if test "${PHOENIX_DEFAULT_PERFORMANCEEVAL_ROW_COUNT}" != "100000"; then \
		sed -i -e "s/^# export PHOENIX_PERFORMANCEEVAL_ROW_COUNT/export PHOENIX_PERFORMANCEEVAL_ROW_COUNT/g" $(1); \
	fi
	sed -i -e 's;DEFAULTJOBOUTPUTFILE;$(JOBOUTPUTFILE);g' $(1)
endef

# User passes in string of everything they want
# Perhaps there is a niftier way to do this in sed than what I'm doing, glad
# to take suggestions.  I couldn't figure out a way to do it in 1 pass.
define common-addition
	for project in hadoop hbase hive phoenix pig spark kafka zeppelin storm zookeeper tensorflow tensorflow-horovod ray alluxio; do \
		if echo $(2) | grep -q $$project; then \
			sed -i -e "/@MAGPIE_JOB_TYPES@/a @MAGPIE_JOB_TYPES_TEMP@/" $(1); \
			sed -i -e "/@MAGPIE_JOB_TYPES@/{r magpie-magpie-customizations-job-$$project" -e "}" $(1); \
			sed -i -e "/@MAGPIE_JOB_TYPES@/d" $(1); \
			sed -i -e "s/@MAGPIE_JOB_TYPES_TEMP@/@MAGPIE_JOB_TYPES@/" $(1); \
			sed -i -e "/@MAGPIE_TESTALL_TYPES@/a @MAGPIE_TESTALL_TYPES_TEMP@/" $(1); \
			sed -i -e "/@MAGPIE_TESTALL_TYPES@/{r magpie-magpie-customizations-testall-$$project" -e "}" $(1); \
			sed -i -e "/@MAGPIE_TESTALL_TYPES@/d" $(1); \
			sed -i -e "s/@MAGPIE_TESTALL_TYPES_TEMP@/@MAGPIE_TESTALL_TYPES@/" $(1); \
		fi \
	done
endef

define common-addition-end
	sed -i -e "/@MAGPIE_JOB_TYPES@/d" $(1)
	sed -i -e "/@MAGPIE_TESTALL_TYPES@/d" $(1)
endef

define common-additions
	$(call common-addition, $(1), $(2))
	$(call common-addition-end, $(1))
endef

define create-bigdata-templates
	cp magpie-magpie-customizations magpie-magpie-customizations-substitution-bigdata

	sed -i -e "/@MAGPIE_SCRIPT@/{r magpie-magpie-customizations-script" -e "d}" magpie-magpie-customizations-substitution-bigdata
	sed -i -e "/@MAGPIE_INTERACTIVE@/{r magpie-magpie-customizations-interactive" -e "d}" magpie-magpie-customizations-substitution-bigdata
	sed -i -e "/@MAGPIE_SETUPONLY@/{r magpie-magpie-customizations-setuponly" -e "d}" magpie-magpie-customizations-substitution-bigdata
	sed -i -e "/@MAGPIE_REMOTE_SHELL@/{r magpie-magpie-customizations-remote-shell" -e "d}" magpie-magpie-customizations-substitution-bigdata
	sed -i -e "/@MAGPIE_ENVIRONMENT_VARIABLE_SCRIPT@/{r magpie-magpie-customizations-environment-variable-script" -e "d}" magpie-magpie-customizations-substitution-bigdata

	if test "${MAGPIE_NO_LOCAL_DIR}" = "y"; then \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/{r magpie-magpie-customizations-no-local-dir" -e "d}" magpie-magpie-customizations-substitution-bigdata; \
	else \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/,+1d" magpie-magpie-customizations-substitution-bigdata; \
	fi

	if test "${MAGPIE_HOSTNAME_MAP}" = "y"; then \
		sed -i -e "/@MAGPIE_HOSTNAME_MAP@/{r magpie-magpie-customizations-hostname-map" -e "d}" magpie-magpie-customizations-substitution-bigdata; \
	else \
		sed -i -e "/@MAGPIE_HOSTNAME_MAP@/,+1d" magpie-magpie-customizations-substitution-bigdata; \
	fi

	cp magpie-hadoop-filesystem magpie-hadoop-filesystem-substitution

	if test "${INSERT_HDFSOVERLUSTRE}" = "y"; then \
		sed -i -e "/@MODE_HDFSOVERLUSTRE@/{r magpie-hadoop-filesystem-mode-hdfsoverlustre" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_HDFSOVERLUSTRE@/{r magpie-hadoop-filesystem-config-hdfsoverlustre" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_HDFSOVERLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_HDFSOVERLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

	if test "${INSERT_HDFSOVERNETWORKFS}" = "y"; then \
		sed -i -e "/@MODE_HDFSOVERNETWORKFS@/{r magpie-hadoop-filesystem-mode-hdfsovernetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_HDFSOVERNETWORKFS@/{r magpie-hadoop-filesystem-config-hdfsovernetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_HDFSOVERNETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_HDFSOVERNETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

	cp magpie-run-job-header magpie-run-job-header-substitution

	if test "${LOCAL_REQUIREMENTS}" = "y"; then \
		if ! test -f "${LOCAL_REQUIREMENTS_FILE}"; then \
			echo "File ${LOCAL_REQUIREMENTS_FILE} is not a normal file"; \
			exit 1; \
		fi; \
		sed -i -e "/@LOCALREQUIREMENTS@/{r ${LOCAL_REQUIREMENTS_FILE}" -e "d}" magpie-run-job-header-substitution; \
	else \
		sed -i -e "/@LOCALREQUIREMENTS@/,+1d" magpie-run-job-header-substitution; \
	fi

	$(eval SCHED := $(1))
	$(eval DIST := $(2))
	$(eval JOBOUTPUTFILE := $(3))
	echo "Creating magpie.$(SCHED)"
	mkdir -p ../script-$(SCHED)
	$(eval MAGPIE := ../script-$(SCHED)/magpie.$(SCHED))
	$(eval MAGPIE_HADOOP := ../script-$(SCHED)/magpie.$(SCHED)-hadoop)
	$(eval MAGPIE_HADOOP_AND_PIG := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-and-pig)
	$(eval MAGPIE_HADOOP_AND_HIVE := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-and-hive)
	$(eval MAGPIE_HBASE_WITH_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-hbase-with-hdfs)
	$(eval MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX := ../script-$(SCHED)/magpie.$(SCHED)-hbase-with-hdfs-with-phoenix)
	$(eval MAGPIE_SPARK := ../script-$(SCHED)/magpie.$(SCHED)-spark)
	$(eval MAGPIE_SPARK_WITH_ALLUXIO := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-alluxio)
	$(eval MAGPIE_SPARK_WITH_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-hdfs)
	$(eval MAGPIE_SPARK_WITH_YARN := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-yarn)
	$(eval MAGPIE_SPARK_WITH_YARN_AND_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-yarn-and-hdfs)
	$(eval MAGPIE_SPARK_WITH_ZEPPELIN := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-zeppelin)
	$(eval MAGPIE_STORM := ../script-$(SCHED)/magpie.$(SCHED)-storm)
	$(eval MAGPIE_ALLUXIO := ../script-$(SCHED)/magpie.$(SCHED)-alluxio)

	$(call create-all)
	$(if $(findstring "${HADOOP_INCLUDE}", "y"), $(call create-hadoop))
	$(if $(findstring "${HADOOP_INCLUDE}${PIG_INCLUDE}", "yy"), $(call create-hadoop-and-pig))
	$(if $(findstring "${HADOOP_INCLUDE}${HIVE_INCLUDE}", "yy"), $(call create-hadoop-and-hive))
	$(if $(findstring "${HADOOP_INCLUDE}${HBASE_INCLUDE}${ZOOKEEPER_INCLUDE}", "yyy"), $(call create-hbase-with-hdfs))
	$(if $(findstring "${HADOOP_INCLUDE}${HBASE_INCLUDE}${PHOENIX_INCLUDE}${ZOOKEEPER_INCLUDE}", "yyyy"), $(call create-hbase-with-hdfs-with-phoenix))
	$(if $(findstring "${SPARK_INCLUDE}", "y"), $(call create-spark))
	$(if $(findstring "${ALLUXIO_INCLUDE}${SPARK_INCLUDE}", "yy"), $(call create-spark-with-alluxio))
	$(if $(findstring "${HADOOP_INCLUDE}${SPARK_INCLUDE}", "yy"), $(call create-spark-with-hdfs))
	$(if $(findstring "${HADOOP_INCLUDE}${SPARK_INCLUDE}", "yy"), $(call create-spark-with-yarn))
	$(if $(findstring "${HADOOP_INCLUDE}${SPARK_INCLUDE}", "yy"), $(call create-spark-with-yarn-and-hdfs))
	$(if $(findstring "${ZEPPELIN_INCLUDE}", "y"), $(call create-spark-with-zeppelin))
	$(if $(findstring "${STORM_INCLUDE}${ZOOKEEPER_INCLUDE}", "yy"), $(call create-storm))
	$(if $(findstring "${ALLUXIO_INCLUDE}", "y"), $(call create-alluxio))

endef

define create-ml-master-worker-templates
	cp magpie-magpie-customizations magpie-magpie-customizations-substitution-ml-master-worker

	sed -i -e "/@MAGPIE_SCRIPT@/{r magpie-magpie-customizations-script" -e "d}" magpie-magpie-customizations-substitution-ml-master-worker
	sed -i -e "/@MAGPIE_INTERACTIVE@/d" magpie-magpie-customizations-substitution-ml-master-worker
	sed -i -e "/@MAGPIE_SETUPONLY@/{r magpie-magpie-customizations-setuponly" -e "d}" magpie-magpie-customizations-substitution-ml-master-worker
	sed -i -e "/@MAGPIE_REMOTE_SHELL@/{r magpie-magpie-customizations-remote-shell" -e "d}" magpie-magpie-customizations-substitution-ml-master-worker
	sed -i -e "/@MAGPIE_ENVIRONMENT_VARIABLE_SCRIPT@/{r magpie-magpie-customizations-environment-variable-script" -e "d}" magpie-magpie-customizations-substitution-ml-master-worker

	if test "${MAGPIE_NO_LOCAL_DIR}" = "y"; then \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/{r magpie-magpie-customizations-no-local-dir" -e "d}" magpie-magpie-customizations-substitution-ml-master-worker; \
	else \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/,+1d" magpie-magpie-customizations-substitution-ml-master-worker; \
	fi

	if test "${MAGPIE_HOSTNAME_MAP}" = "y"; then \
		sed -i -e "/@MAGPIE_HOSTNAME_MAP@/{r magpie-magpie-customizations-hostname-map" -e "d}" magpie-magpie-customizations-substitution-ml-master-worker; \
	else \
		sed -i -e "/@MAGPIE_HOSTNAME_MAP@/,+1d" magpie-magpie-customizations-substitution-ml-master-worker; \
	fi

	cp magpie-run-job-header magpie-run-job-header-substitution

	if test "${LOCAL_REQUIREMENTS}" = "y"; then \
		if ! test -f "${LOCAL_REQUIREMENTS_FILE}"; then \
			echo "File ${LOCAL_REQUIREMENTS_FILE} is not a normal file"; \
			exit 1; \
		fi; \
		sed -i -e "/@LOCALREQUIREMENTS@/{r ${LOCAL_REQUIREMENTS_FILE}" -e "d}" magpie-run-job-header-substitution; \
	else \
		sed -i -e "/@LOCALREQUIREMENTS@/,+1d" magpie-run-job-header-substitution; \
	fi

	$(eval SCHED := $(1))
	$(eval DIST := $(2))
	$(eval JOBOUTPUTFILE := $(3))
	echo "Creating magpie.$(SCHED)"
	mkdir -p ../script-$(SCHED)
	$(eval MAGPIE_RAY := ../script-$(SCHED)/magpie.$(SCHED)-ray)

	$(if $(findstring "${RAY_INCLUDE}", "y"), $(call create-ray))
endef

define create-tensorflow-templates
	cp magpie-magpie-customizations magpie-magpie-customizations-substitution-tensorflow

	sed -i -e "/@MAGPIE_SCRIPT@/d" magpie-magpie-customizations-substitution-tensorflow
	sed -i -e "/@MAGPIE_INTERACTIVE@/d" magpie-magpie-customizations-substitution-tensorflow
	sed -i -e "/@MAGPIE_SETUPONLY@/d" magpie-magpie-customizations-substitution-tensorflow
	sed -i -e "/@MAGPIE_REMOTE_SHELL@/,+1d" magpie-magpie-customizations-substitution-tensorflow
	sed -i -e "/@MAGPIE_ENVIRONMENT_VARIABLE_SCRIPT@/,+1d" magpie-magpie-customizations-substitution-tensorflow

	if test "${MAGPIE_NO_LOCAL_DIR}" = "y"; then \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/{r magpie-magpie-customizations-no-local-dir" -e "d}" magpie-magpie-customizations-substitution-tensorflow; \
	else \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/,+1d" magpie-magpie-customizations-substitution-tensorflow; \
	fi

	if test "${MAGPIE_HOSTNAME_MAP}" = "y"; then \
		sed -i -e "/@MAGPIE_HOSTNAME_MAP@/{r magpie-magpie-customizations-hostname-map" -e "d}" magpie-magpie-customizations-substitution-tensorflow; \
	else \
		sed -i -e "/@MAGPIE_HOSTNAME_MAP@/,+1d" magpie-magpie-customizations-substitution-tensorflow; \
	fi

	cp magpie-run-job-header magpie-run-job-header-substitution

	if test "${LOCAL_REQUIREMENTS}" = "y"; then \
		if ! test -f "${LOCAL_REQUIREMENTS_FILE}"; then \
			echo "File ${LOCAL_REQUIREMENTS_FILE} is not a normal file"; \
			exit 1; \
		fi; \
		sed -i -e "/@LOCALREQUIREMENTS@/{r ${LOCAL_REQUIREMENTS_FILE}" -e "d}" magpie-run-job-header-substitution; \
	else \
		sed -i -e "/@LOCALREQUIREMENTS@/,+1d" magpie-run-job-header-substitution; \
	fi

	$(eval SCHED := $(1))
	$(eval DIST := $(2))
	$(eval JOBOUTPUTFILE := $(3))
	echo "Creating magpie.$(SCHED)"
	mkdir -p ../script-$(SCHED)
	$(eval MAGPIE_TENSORFLOW := ../script-$(SCHED)/magpie.$(SCHED)-tensorflow)
	$(eval MAGPIE_TENSORFLOW_HOROVOD := ../script-$(SCHED)/magpie.$(SCHED)-tensorflow-horovod)
	$(eval MAGPIE_RAY := ../script-$(SCHED)/magpie.$(SCHED)-ray)

	$(if $(findstring "${TENSORFLOW_INCLUDE}", "y"), $(call create-tensorflow))
	$(if $(findstring "${TENSORFLOW_HOROVOD_INCLUDE}", "y"), $(call create-tensorflow-horovod))
	$(if $(findstring "${RAY_INCLUDE}", "y"), $(call create-ray))
endef

define create-all
	echo "Creating magpie.$(SCHED)"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python > $(MAGPIE)

		if test "${HADOOP_INCLUDE}" = "y"; then \
			cat magpie-hadoop-core \
				magpie-hadoop-job \
				magpie-hadoop-filesystem-substitution >> $(MAGPIE);\
		fi

		if test "${PIG_INCLUDE}" = "y"; then \
			cat magpie-pig >> $(MAGPIE); \
		fi

		if test "${HBASE_INCLUDE}" = "y"; then \
			cat magpie-hbase >> $(MAGPIE); \
		fi

		if test "${HIVE_INCLUDE}" = "y"; then \
			cat magpie-hive >> $(MAGPIE); \
		fi

		if test "${PHOENIX_INCLUDE}" = "y"; then \
			cat magpie-phoenix >> $(MAGPIE); \
		fi

		if test "${SPARK_INCLUDE}" = "y"; then \
			cat magpie-spark >> $(MAGPIE); \
		fi

		if test "${KAFKA_INCLUDE}" = "y"; then \
			cat magpie-kafka >> $(MAGPIE); \
		fi

		if test "${ZEPPELIN_INCLUDE}" = "y"; then \
			cat magpie-zeppelin >> $(MAGPIE); \
		fi

		if test "${STORM_INCLUDE}" = "y"; then \
			cat magpie-storm >> $(MAGPIE); \
		fi

		if test "${ZOOKEEPER_INCLUDE}" = "y"; then \
			cat magpie-zookeeper >> $(MAGPIE); \
		fi

		if test "${ALLUXIO_INCLUDE}" = "y"; then \
			cat magpie-alluxio >> $(MAGPIE); \
		fi

	cat	magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker >> $(MAGPIE)
	$(call common-substitution, ${MAGPIE},${JAVA_DEFAULT})
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${HADOOP_INCLUDE}", "y"), "hadoop"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${HBASE_INCLUDE}", "y"), "hbase"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${HIVE_INCLUDE}", "y"), "hive"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${PHOENIX_INCLUDE}", "y"), "phoenix"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${PIG_INCLUDE}", "y"), "pig"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${SPARK_INCLUDE}", "y"), "spark"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${KAFKA_INCLUDE}", "y"), "kafka"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${ZEPPELIN_INCLUDE}", "y"), "zeppelin"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${STORM_INCLUDE}", "y"), "storm"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${ZOOKEEPER_INCLUDE}", "y"), "zookeeper"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${ALLUXIO_INCLUDE}", "y"), "alluxio"))
	$(call common-addition-end, ${MAGPIE})
endef

define create-hadoop
	echo "Creating magpie.$(SCHED)-hadoop"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_HADOOP)
	$(call common-substitution, ${MAGPIE_HADOOP},${HADOOP_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_HADOOP}, hadoop)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP)
endef

define create-hadoop-and-pig
	echo "Creating magpie.$(SCHED)-hadoop-and-pig"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-pig \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_HADOOP_AND_PIG)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_PIG},${PIG_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_HADOOP_AND_PIG}, hadoop pig)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"pig\"/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(PIG_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/PIG_SETUP=.*/PIG_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
endef

define create-hadoop-and-hive
echo "Creating magpie.$(SCHED)-hadoop-and-hive"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hive \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_HADOOP_AND_HIVE)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_HIVE},${JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_HADOOP_AND_HIVE}, hadoop hive)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hive\"/" $(MAGPIE_HADOOP_AND_HIVE)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_HIVE)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_HIVE)
	sed -i -e "s/HIVE_SETUP=.*/HIVE_SETUP=yes/" $(MAGPIE_HADOOP_AND_HIVE)
        sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HADOOP_AND_HIVE)
endef

define create-hbase-with-hdfs
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hbase \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_HBASE_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS},${HBASE_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_HBASE_WITH_HDFS}, hbase zookeeper)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hbase\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(HBASE_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HBASE_SETUP=.*/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_VERSION=\"\(.*\)\"/ZOOKEEPER_VERSION=\"$(HBASE_ZOOKEEPER_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS)
endef

define create-hbase-with-hdfs-with-phoenix
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs-with-phoenix"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hbase \
                magpie-phoenix \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX},${PHOENIX_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX}, hbase phoenix zookeeper)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"phoenix\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(PHOENIX_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HBASE_SETUP=.*/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HBASE_VERSION=\"\(.*\)\"/HBASE_VERSION=\"$(PHOENIX_HBASE_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/PHOENIX_SETUP=.*/PHOENIX_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/ZOOKEEPER_VERSION=\"\(.*\)\"/ZOOKEEPER_VERSION=\"$(PHOENIX_ZOOKEEPER_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
endef

define create-spark
	echo "Creating magpie.$(SCHED)-spark"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_SPARK)
	$(call common-substitution, ${MAGPIE_SPARK},${SPARK_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_SPARK}, spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR=/export SPARK_LOCAL_SCRATCH_DIR=/g" $(MAGPIE_SPARK)
endef

define create-spark-with-alluxio
	echo "Creating magpie.$(SCHED)-spark-with-alluxio"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-header-intel \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-spark \
		magpie-alluxio \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_SPARK_WITH_ALLUXIO)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_ALLUXIO},${SPARK_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_SPARK_WITH_ALLUXIO}, spark alluxio)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_ALLUXIO)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_ALLUXIO)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR=/export SPARK_LOCAL_SCRATCH_DIR=/g" $(MAGPIE_SPARK_WITH_ALLUXIO)
	sed -i -e "s/ALLUXIO_SETUP=.*/ALLUXIO_SETUP=yes/" $(MAGPIE_SPARK_WITH_ALLUXIO)
endef

define create-spark-with-hdfs
	echo "Creating magpie.$(SCHED)-spark-with-hdfs"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_SPARK_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_HDFS},${SPARK_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_SPARK_WITH_HDFS}, spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(SPARK_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
endef

define create-spark-with-yarn
	echo "Creating magpie.$(SCHED)-spark-with-yarn"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_SPARK_WITH_YARN)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_YARN},${SPARK_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_SPARK_WITH_YARN}, hadoop spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_YARN)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_YARN)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"YARN\"/" $(MAGPIE_SPARK_WITH_YARN)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(SPARK_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_YARN)
	sed -i -e "s/HADOOP_FILESYSTEM_MODE=\"\(.*\)\"/HADOOP_FILESYSTEM_MODE=\"rawnetworkfs\"/" $(MAGPIE_SPARK_WITH_YARN)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_YARN)
	sed -i -e "s/SPARK_SETUP_TYPE=\"\(.*\)\"/SPARK_SETUP_TYPE=\"YARN\"/g" $(MAGPIE_SPARK_WITH_YARN)
endef

define create-spark-with-yarn-and-hdfs
	echo "Creating magpie.$(SCHED)-spark-with-yarn-and-hdfs"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_YARN_AND_HDFS},${SPARK_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_SPARK_WITH_YARN_AND_HDFS}, hadoop spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(SPARK_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/SPARK_SETUP_TYPE=\"\(.*\)\"/SPARK_SETUP_TYPE=\"YARN\"/g" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
endef

define create-spark-with-zeppelin
	echo "Creating magpie.$(SCHED)-spark-with-zeppelin"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-spark \
		magpie-zeppelin \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_SPARK_WITH_ZEPPELIN)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_ZEPPELIN},${ZEPPELIN_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_SPARK_WITH_ZEPPELIN}, spark zeppelin)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"zeppelin\"/" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e "s/SPARK_VERSION=\"\(.*\)\"/SPARK_VERSION=\"$(ZEPPELIN_SPARK_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR=/export SPARK_LOCAL_SCRATCH_DIR=/g" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e 's/export ZEPPELIN_SETUP=no/export ZEPPELIN_SETUP=yes/' $(MAGPIE_SPARK_WITH_ZEPPELIN)
endef

define create-storm
	echo "Creating magpie.$(SCHED)-storm"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-storm \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_STORM)
	$(call common-substitution, ${MAGPIE_STORM},${STORM_JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_STORM}, storm zookeeper)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"storm\"/" $(MAGPIE_STORM)
	sed -i -e "s/STORM_SETUP=.*/STORM_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_VERSION=\"\(.*\)\"/ZOOKEEPER_VERSION=\"$(STORM_ZOOKEEPER_VERSION_DEFAULT)\"/" $(MAGPIE_STORM)
endef

define create-ray
	echo "Creating magpie.$(SCHED)-ray"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-ml-master-worker \
		magpie-general-configuration-header \
		magpie-general-configuration-python \
		magpie-ray \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_RAY)
	$(call common-substitution, ${MAGPIE_RAY},${JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_RAY}, ray)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"ray\"/" $(MAGPIE_RAY)
	sed -i -e "s/RAY_SETUP=.*/RAY_SETUP=yes/" $(MAGPIE_RAY)
endef

define create-alluxio
	echo "Creating magpie.$(SCHED)-alluxio"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-header-intel \
		magpie-config-$(SCHED)-header \
		magpie-config-bigdata-instructions \
		magpie-config-$(SCHED)-master-worker \
		magpie-magpie-customizations-substitution-bigdata \
		magpie-general-configuration-header \
		magpie-general-configuration-java \
		magpie-general-configuration-python \
		magpie-alluxio \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-master-worker > $(MAGPIE_ALLUXIO)
	$(call common-substitution, ${MAGPIE_ALLUXIO},${JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_ALLUXIO}, alluxio)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"alluxio\"/" $(MAGPIE_ALLUXIO)
	sed -i -e "s/ALLUXIO_SETUP=.*/ALLUXIO_SETUP=yes/" $(MAGPIE_ALLUXIO)
endef

define create-tensorflow
	echo "Creating magpie.$(SCHED)-tensorflow"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-config-$(SCHED)-header \
		magpie-config-$(SCHED)-distributed \
		magpie-magpie-customizations-substitution-tensorflow \
		magpie-general-configuration-header \
		magpie-general-configuration-python \
		magpie-tensorflow \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-distributed > $(MAGPIE_TENSORFLOW)
	$(call common-substitution, ${MAGPIE_TENSORFLOW},${JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_TENSORFLOW}, tensorflow)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"tensorflow\"/" $(MAGPIE_TENSORFLOW)
	sed -i -e "s/TENSORFLOW_SETUP=.*/TENSORFLOW_SETUP=yes/" $(MAGPIE_TENSORFLOW)
endef

define create-tensorflow-horovod
	echo "Creating magpie.$(SCHED)-tensorflow-horovod"
	cat 	magpie-shebang \
		magpie-header-llnl \
		magpie-header-intel \
		magpie-config-$(SCHED)-header \
		magpie-config-$(SCHED)-distributed \
		magpie-magpie-customizations-substitution-tensorflow \
		magpie-general-configuration-header \
		magpie-general-configuration-python \
		magpie-tensorflow-horovod \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST)-distributed > $(MAGPIE_TENSORFLOW_HOROVOD)
	$(call common-substitution, ${MAGPIE_TENSORFLOW_HOROVOD},${JAVA_DEFAULT})
	$(call common-additions, ${MAGPIE_TENSORFLOW_HOROVOD}, tensorflow-horovod)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"tensorflow-horovod\"/" $(MAGPIE_TENSORFLOW_HOROVOD)
	sed -i -e "s/TENSORFLOW_HOROVOD_SETUP=.*/TENSORFLOW_HOROVOD_SETUP=yes/" $(MAGPIE_TENSORFLOW_HOROVOD)
endef
