# Creation options, set to y or n
#
# Note that Hbase requires Hadoop, Hbase & Storm require Zookeeper
#
# MAGPIE_NO_LOCAL_DIR - support MAGPIE_NO_LOCAL_DIR
#
# INSERT_INTELLUSTRE - insert intellustre configuration
#
# INSERT_MAGPIENETWORKFS - insert magpienetworkfs configuration
#
# INSERT_HDFSOVERLUSTRE - insert HDFS over Lustre configuration
#
# INSERT_HDFSOVERNETWORKFS - insert HDFS over NetworkFS configuration
#
# INSERT_HDFS_FEDERATION - insert HDFS federation configuration 
#
HADOOP_INCLUDE=y
PIG_INCLUDE=y
MAHOUT_INCLUDE=y
UDA_INCLUDE=y
HBASE_INCLUDE=y
PHOENIX_INCLUDE=y
SPARK_INCLUDE=y
KAFKA_INCLUDE=y
STORM_INCLUDE=y
TACHYON_INCLUDE=y
ZEPPELIN_INCLUDE=y
ZOOKEEPER_INCLUDE=y

MAGPIE_NO_LOCAL_DIR=n
INSERT_INTELLUSTRE=n
INSERT_MAGPIENETWORKFS=n
INSERT_HDFSOVERLUSTRE=y
INSERT_HDFSOVERNETWORKFS=y
INSERT_HDFS_FEDERATION=n

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
KAFKA_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
MAHOUT_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
PHOENIX_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
PIG_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
SPARK_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
STORM_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
TACHYON_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
UDA_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
ZEPPELIN_DIR_PREFIX=$(PROJECT_DIR_PREFIX)
ZOOKEEPER_DIR_PREFIX=$(PROJECT_DIR_PREFIX)

REMOTE_CMD_DEFAULT=ssh

JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0-oracle.x86_64/
PYTHON_DEFAULT=/usr/bin/python

#
# Misc defaults you may wish to set
#

HADOOP_FILESYSTEM_MODE="hdfsoverlustre"
ZOOKEEPER_REPLICATION_COUNT=3
HADOOP_DEFAULT_TERASORT_SIZE=50000000
HBASE_DEFAULT_PERFORMANCEEVAL_ROW_COUNT=1048576
PHOENIX_DEFAULT_PERFORMANCEEVAL_ROW_COUNT=100000

#
# Adjust for default versions
#
HADOOP_VERSION_DEFAULT=2.7.3
PIG_VERSION_DEFAULT=0.16.0
MAHOUT_VERSION_DEFAULT=0.12.2
HBASE_VERSION_DEFAULT=1.3.0
HBASE_ZOOKEEPER_VERSION_DEFAULT=3.4.9
PHOENIX_VERSION_DEFAULT=4.10.0-HBase-1.2
PHOENIX_HBASE_VERSION_DEFAULT=1.2.4
PHOENIX_ZOOKEEPER_VERSION_DEFAULT=3.4.9
SPARK_VERSION_DEFAULT=2.1.0-bin-hadoop2.7
SPARK_HADOOP_VERSION_DEFAULT=2.7.3
KAFKA_VERSION_DEFAULT=2.11-0.9.0.0
STORM_VERSION_DEFAULT=1.0.3
STORM_ZOOKEEPER_VERSION_DEFAULT=3.4.9
ZOOKEEPER_VERSION_DEFAULT=3.4.9
TACHYON_VERSION_DEFAULT=0.6.1
ZEPPELIN_VERSION_DEFAULT=0.7.1
ZEPPELIN_SPARK_VERSION_DEFAULT=1.6.3-bin-hadoop2.6

#
# If LOCAL_REQUIREMENTS is set to 'y', whatever is in the file pointed
# by LOCAL_REQUIREMENTS_FILE will be added to submission scripts
# before the first call to magpie-check-inputs
#
LOCAL_REQUIREMENTS=n
LOCAL_REQUIREMENTS_FILE=/tmp/mylocal

# Default job files
SBATCH_SRUN_DEFAULT_JOB_FILE=slurm-%j.out
MSUB_SLURM_SRUN_DEFAULT_JOB_FILE=moab-%j.out
MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE=moab-%j.out
LSF_MPIRUN_DEFAULT_JOB_FILE=lsf-%J.out

.DEFAULT_GOAL=all

all: msub-slurm-srun sbatch-srun msub-torque-pdsh lsf-mpirun

clean-sbatch-srun:
	rm -f ../script-sbatch-srun/magpie.sbatch-srun*

clean-msub-slurm-srun:
	rm -f ../script-msub-slurm-srun/magpie.msub-slurm*

clean-msub-torque-pdsh:
	rm -f ../script-msub-torque-pdsh/magpie.msub-torque*

clean-lsf-mpirun:
	rm -f ../script-lsf-mpirun/magpie.lsf-mpirun*

clean: clean-sbatch-srun clean-msub-slurm-srun clean-msub-torque-pdsh clean-lsf-mpirun

sbatch-srun: clean-sbatch-srun
	$(call create-templates,$@,srun,$(SBATCH_SRUN_DEFAULT_JOB_FILE))

msub-slurm-srun: clean-msub-slurm-srun
	$(call create-templates,$@,srun,$(MSUB_SLURM_SRUN_DEFAULT_JOB_FILE))

msub-torque-pdsh: clean-msub-torque-pdsh
	$(call create-templates,$@,pdsh,$(MSUB_TORQUE_PDSH_DEFAULT_JOB_FILE))

lsf-mpirun: clean-lsf-mpirun
	$(call create-templates,$@,mpirun,$(LSF_MPIRUN_DEFAULT_JOB_FILE))

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
	sed -i -e 's;KAFKADIRPREFIX;$(KAFKA_DIR_PREFIX);g' $(1)
	sed -i -e 's;MAHOUTDIRPREFIX;$(MAHOUT_DIR_PREFIX);g' $(1)
	sed -i -e 's;PHOENIXDIRPREFIX;$(PHOENIX_DIR_PREFIX);g' $(1)
	sed -i -e 's;PIGDIRPREFIX;$(PIG_DIR_PREFIX);g' $(1)
	sed -i -e 's;SPARKDIRPREFIX;$(SPARK_DIR_PREFIX);g' $(1)
	sed -i -e 's;STORMDIRPREFIX;$(STORM_DIR_PREFIX);g' $(1)
	sed -i -e 's;TACHYONDIRPREFIX;$(TACHYON_DIR_PREFIX);g' $(1)
	sed -i -e 's;UDADIRPREFIX;$(UDA_DIR_PREFIX);g' $(1)
	sed -i -e 's;ZEPPELINDIRPREFIX;$(ZEPPELIN_DIR_PREFIX);g' $(1)
	sed -i -e 's;ZOOKEEPERDIRPREFIX;$(ZOOKEEPER_DIR_PREFIX);g' $(1)

	sed -i -e 's;HADOOPVERSIONDEFAULT;$(HADOOP_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;PIGVERSIONDEFAULT;$(PIG_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;MAHOUTVERSIONDEFAULT;$(MAHOUT_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;HBASEVERSIONDEFAULT;$(HBASE_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;PHOENIXVERSIONDEFAULT;$(PHOENIX_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;SPARKVERSIONDEFAULT;$(SPARK_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;KAFKAVERSIONDEFAULT;$(KAFKA_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;STORMVERSIONDEFAULT;$(STORM_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;ZOOKEEPERVERSIONDEFAULT;$(ZOOKEEPER_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;TACHYONVERSIONDEFAULT;$(TACHYON_VERSION_DEFAULT);g' $(1)
	sed -i -e 's;ZEPPELINVERSIONDEFAULT;$(ZEPPELIN_VERSION_DEFAULT);g' $(1)

	sed -i -e 's;REMOTECMDDEFAULT;$(REMOTE_CMD_DEFAULT);g' $(1)
	if test "${REMOTE_CMD_DEFAULT}" != "ssh"; then \
		sed -i -e "s/^# export MAGPIE_REMOTE_CMD/export MAGPIE_REMOTE_CMD/g" $(1); \
	fi
	sed -i -e 's;JAVADEFAULT;$(JAVA_DEFAULT);g' $(1)
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
	for project in hadoop hbase phoenix pig mahout spark kafka zeppelin storm tachyon zookeeper; do \
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

define create-templates
	cp magpie-magpie-customizations magpie-magpie-customizations-substitution

	if test "${MAGPIE_NO_LOCAL_DIR}" = "y"; then \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/{r magpie-magpie-customizations-no-local-dir" -e "d}" magpie-magpie-customizations-substitution; \
	else \
		sed -i -e "/@MAGPIE_NO_LOCAL_DIR@/,+1d" magpie-magpie-customizations-substitution; \
	fi

	cp magpie-hadoop-filesystem magpie-hadoop-filesystem-substitution

	if test "${INSERT_INTELLUSTRE}" = "y"; then \
		sed -i -e "/@MODE_INTELLUSTRE@/{r magpie-hadoop-filesystem-mode-intellustre" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_INTELLUSTRE@/{r magpie-hadoop-filesystem-config-intellustre" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_INTELLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_INTELLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

	if test "${INSERT_MAGPIENETWORKFS}" = "y"; then \
		sed -i -e "/@MODE_MAGPIENETWORKFS@/{r magpie-hadoop-filesystem-mode-magpienetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_MAGPIENETWORKFS@/{r magpie-hadoop-filesystem-config-magpienetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_MAGPIENETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_MAGPIENETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

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

	if test "${INSERT_HDFS_FEDERATION}" = "y"; then \
		sed -i -e "/@HDFS_FEDERATION@/{r magpie-hadoop-filesystem-hdfs-federation" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@HDFS_FEDERATION@/,+1d" magpie-hadoop-filesystem-substitution; \
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
	$(eval MAGPIE_HADOOP_WITH_UDA := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-with-uda)
	$(eval MAGPIE_HADOOP_AND_PIG := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-and-pig)
	$(eval MAGPIE_HADOOP_AND_MAHOUT := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-and-mahout)
	$(eval MAGPIE_HBASE_WITH_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-hbase-with-hdfs)
	$(eval MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX := ../script-$(SCHED)/magpie.$(SCHED)-hbase-with-hdfs-with-phoenix)
	$(eval MAGPIE_SPARK := ../script-$(SCHED)/magpie.$(SCHED)-spark)
	$(eval MAGPIE_SPARK_WITH_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-hdfs)
	$(eval MAGPIE_SPARK_WITH_YARN_AND_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-yarn-and-hdfs)
	$(eval MAGPIE_SPARK_WITH_TACHYON_AND_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-tachyon-and-hdfs)
	$(eval MAGPIE_SPARK_WITH_ZEPPELIN := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-zeppelin)
	$(eval MAGPIE_STORM := ../script-$(SCHED)/magpie.$(SCHED)-storm)
	cp magpie-header $(MAGPIE)

	$(call create-all)
	$(if $(findstring "${HADOOP_INCLUDE}", "y"), $(call create-hadoop))
	$(if $(findstring "${HADOOP_INCLUDE}${UDA_INCLUDE}", "yy"), $(call create-hadoop-with-uda))
	$(if $(findstring "${HADOOP_INCLUDE}${PIG_INCLUDE}", "yy"), $(call create-hadoop-and-pig))
	$(if $(findstring "${HADOOP_INCLUDE}${MAHOUT_INCLUDE}", "yy"), $(call create-hadoop-and-mahout))
	$(if $(findstring "${HADOOP_INCLUDE}${HBASE_INCLUDE}${ZOOKEEPER_INCLUDE}", "yyy"), $(call create-hbase-with-hdfs))
	$(if $(findstring "${HADOOP_INCLUDE}${HBASE_INCLUDE}${PHOENIX_INCLUDE}${ZOOKEEPER_INCLUDE}", "yyyy"), $(call create-hbase-with-hdfs-with-phoenix))
	$(if $(findstring "${SPARK_INCLUDE}", "y"), $(call create-spark))
	$(if $(findstring "${HADOOP_INCLUDE}${SPARK_INCLUDE}", "yy"), $(call create-spark-with-hdfs))
	$(if $(findstring "${HADOOP_INCLUDE}${SPARK_INCLUDE}", "yy"), $(call create-spark-with-yarn-and-hdfs))
	$(if $(findstring "${HADOOP_INCLUDE}${SPARK_INCLUDE}${TACHYON_INCLUDE}", "yyy"), $(call create-spark-with-tachyon-and-hdfs))
	$(if $(findstring "${ZEPPELIN_INCLUDE}", "y"), $(call create-spark-with-zeppelin))
	$(if $(findstring "${STORM_INCLUDE}${ZOOKEEPER_INCLUDE}", "yy"), $(call create-storm))
endef

define create-all
	echo "Creating magpie.$(SCHED)"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-general-configuration-python > $(MAGPIE)

		if test "${HADOOP_INCLUDE}" = "y"; then \
			cat magpie-hadoop-core \
				magpie-hadoop-job \
				magpie-hadoop-job-details \
				magpie-hadoop-filesystem-substitution \
				magpie-hadoop-mode-terasort \
				magpie-hadoop-mode-details >> $(MAGPIE); \
		fi
		if test "${UDA_INCLUDE}" = "y"; then \
			cat magpie-uda >> $(MAGPIE); \
		fi

		if test "${PIG_INCLUDE}" = "y"; then \
			cat magpie-pig >> $(MAGPIE); \
		fi

		if test "${MAHOUT_INCLUDE}" = "y"; then \
			cat magpie-mahout >> $(MAGPIE); \
		fi

		if test "${HBASE_INCLUDE}" = "y"; then \
			cat magpie-hbase >> $(MAGPIE); \
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

		if test "${TACHYON_INCLUDE}" = "y"; then \
			cat magpie-tachyon >> $(MAGPIE); \
		fi

		if test "${ZOOKEEPER_INCLUDE}" = "y"; then \
			cat magpie-zookeeper >> $(MAGPIE); \
		fi

	cat	magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) >> $(MAGPIE)
	$(call common-substitution, ${MAGPIE})
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${HADOOP_INCLUDE}", "y"), "hadoop"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${HBASE_INCLUDE}", "y"), "hbase"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${PHOENIX_INCLUDE}", "y"), "phoenix"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${PIG_INCLUDE}", "y"), "pig"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${MAHOUT_INCLUDE}", "y"), "mahout"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${SPARK_INCLUDE}", "y"), "spark"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${KAFKA_INCLUDE}", "y"), "kafka"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${ZEPPELIN_INCLUDE}", "y"), "zeppelin"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${STORM_INCLUDE}", "y"), "storm"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${TACHYON_INCLUDE}", "y"), "tachyon"))
	$(call common-addition, ${MAGPIE}, $(if $(findstring "${ZOOKEEPER_INCLUDE}", "y"), "zookeeper"))
	$(call common-addition-end, ${MAGPIE})
endef

define create-hadoop
	echo "Creating magpie.$(SCHED)-hadoop"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-terasort \
		magpie-hadoop-mode-details \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP)
	$(call common-substitution, ${MAGPIE_HADOOP})
	$(call common-additions, ${MAGPIE_HADOOP}, hadoop)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP)
endef

define create-hadoop-with-uda
	echo "Creating magpie.$(SCHED)-hadoop-with-uda"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-terasort \
		magpie-hadoop-mode-details \
		magpie-uda \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_WITH_UDA)
	$(call common-substitution, ${MAGPIE_HADOOP_WITH_UDA})
	$(call common-additions, ${MAGPIE_HADOOP_WITH_UDA}, hadoop)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_WITH_UDA)
endef

define create-hadoop-and-pig
	echo "Creating magpie.$(SCHED)-hadoop-and-pig"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-pig \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_AND_PIG)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_PIG})
	$(call common-additions, ${MAGPIE_HADOOP_AND_PIG}, hadoop pig)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"pig\"/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/PIG_SETUP=.*/PIG_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
endef

define create-hadoop-and-mahout
	echo "Creating magpie.$(SCHED)-hadoop-and-mahout"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-mahout \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_AND_MAHOUT)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_MAHOUT})
	$(call common-additions, ${MAGPIE_HADOOP_AND_MAHOUT}, hadoop mahout)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"mahout\"/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/MAHOUT_SETUP=.*/MAHOUT_SETUP=yes/" $(MAGPIE_HADOOP_AND_MAHOUT)
endef

define create-hbase-with-hdfs
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-hbase \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HBASE_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS})
	$(call common-additions, ${MAGPIE_HBASE_WITH_HDFS}, hbase zookeeper)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hbase\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HBASE_SETUP=.*/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_VERSION=\"\(.*\)\"/ZOOKEEPER_VERSION=\"$(HBASE_ZOOKEEPER_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS)
endef

define create-hbase-with-hdfs-with-phoenix 
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs-with-phoenix"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-hbase \
                magpie-phoenix \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX})
	$(call common-additions, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX}, hbase phoenix zookeeper)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"phoenix\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HBASE_SETUP=.*/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HBASE_VERSION=\"\(.*\)\"/HBASE_VERSION=\"$(PHOENIX_HBASE_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/PHOENIX_SETUP=.*/PHOENIX_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/ZOOKEEPER_VERSION=\"\(.*\)\"/ZOOKEEPER_VERSION=\"$(PHOENIX_ZOOKEEPER_VERSION_DEFAULT)\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
endef

define create-spark
	echo "Creating magpie.$(SCHED)-spark"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-general-configuration-python \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK)
	$(call common-substitution, ${MAGPIE_SPARK})
	$(call common-additions, ${MAGPIE_SPARK}, spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR=/export SPARK_LOCAL_SCRATCH_DIR=/g" $(MAGPIE_SPARK)
endef

define create-spark-with-hdfs
	echo "Creating magpie.$(SCHED)-spark-with-hdfs"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-general-configuration-python \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_HDFS})
	$(call common-additions, ${MAGPIE_SPARK_WITH_HDFS}, spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(SPARK_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
endef

define create-spark-with-yarn-and-hdfs
	echo "Creating magpie.$(SCHED)-spark-with-yarn-and-hdfs"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-general-configuration-python \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_YARN_AND_HDFS})
	$(call common-additions, ${MAGPIE_SPARK_WITH_YARN_AND_HDFS}, hadoop spark)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(SPARK_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
	sed -i -e "s/^# export SPARK_USE_YARN/export SPARK_USE_YARN/g" $(MAGPIE_SPARK_WITH_YARN_AND_HDFS)
endef

define create-spark-with-tachyon-and-hdfs
	echo "Creating magpie.$(SCHED)-spark-with-tachyon-and-hdfs"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-general-configuration-python \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-spark \
		magpie-tachyon \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_TACHYON_AND_HDFS})
	$(call common-additions, ${MAGPIE_SPARK_WITH_TACHYON_AND_HDFS}, spark tachyon)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_VERSION=\"\(.*\)\"/HADOOP_VERSION=\"$(SPARK_HADOOP_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_MODE=\"\(.*\)\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/TACHYON_SETUP=.*/TACHYON_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
endef

define create-spark-with-zeppelin
	echo "Creating magpie.$(SCHED)-spark-with-zeppelin"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-general-configuration-python \
		magpie-spark \
		magpie-zeppelin \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_ZEPPELIN)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_ZEPPELIN})
	$(call common-additions, ${MAGPIE_SPARK_WITH_ZEPPELIN}, spark zeppelin)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"zeppelin\"/" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR=/export SPARK_LOCAL_SCRATCH_DIR=/g" $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e 's/export ZEPPELIN_SETUP=no/export ZEPPELIN_SETUP=yes/' $(MAGPIE_SPARK_WITH_ZEPPELIN)
	sed -i -e "s/SPARK_VERSION=\"\(.*\)\"/SPARK_VERSION=\"$(ZEPPELIN_SPARK_VERSION_DEFAULT)\"/" $(MAGPIE_SPARK_WITH_ZEPPELIN)
endef

define create-storm
	echo "Creating magpie.$(SCHED)-storm"
	cat 	magpie-header \
		magpie-config-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-storm \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_STORM)
	$(call common-substitution, ${MAGPIE_STORM})
	$(call common-additions, ${MAGPIE_STORM}, storm zookeeper)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"storm\"/" $(MAGPIE_STORM)
	sed -i -e "s/STORM_SETUP=.*/STORM_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_VERSION=\"\(.*\)\"/ZOOKEEPER_VERSION=\"$(STORM_ZOOKEEPER_VERSION_DEFAULT)\"/" $(MAGPIE_STORM)
endef
