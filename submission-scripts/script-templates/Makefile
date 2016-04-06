# Creation options, set to y or n
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
PROJECT_DIR_PREFIX=$${HOME}
HOME_DIR_PREFIX=$${HOME}
LUSTRE_DIR_PREFIX=/lustre/$${USER}
NETWORKFS_DIR_PREFIX=/networkfs/$${USER}
ZOOKEEPER_DATA_DIR_PREFIX=/lustre/$${USER}
LOCAL_DRIVE_PREFIX=/ssd/$${USER}

REMOTE_CMD_DEFAULT=ssh

JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0-oracle.x86_64/

HADOOP_FILESYSTEM_MODE="hdfsoverlustre"

#
# Adjust for default versions
#
HADOOP_VERSION_DEFAULT=2.7.2
PIG_VERSION_DEFAULT=0.15.0
MAHOUT_VERSION_DEFAULT=0.11.2
HBASE_VERSION_DEFAULT=1.2.0
PHOENIX_VERSION_DEFAULT=4.6.0-HBase-1.1
SPARK_VERSION_DEFAULT=1.6.1-bin-hadoop2.6
KAFKA_VERSION_DEFAULT=2.11-0.9.0.0
STORM_VERSION_DEFAULT=0.10.0
ZOOKEEPER_VERSION_DEFAULT=3.4.8
TACHYON_VERSION_DEFAULT=0.6.1
ZEPPELIN_VERSION_DEFAULT=0.5.6

#
# Adjust to include/remove non-core elements of Magpie
#
# Core is Hadoop, Pig, Hbase, Spark, and Zookeeper
#
MAHOUT_INCLUDE=y
UDA_INCLUDE=y
PHOENIX_INCLUDE=y
KAFKA_INCLUDE=y
STORM_INCLUDE=y
TACHYON_INCLUDE=y
ZEPPELIN_INCLUDE=y

#
# If LOCAL_REQUIREMENTS is set to 'y', whatever is in the file pointed
# by LOCAL_REQUIREMENTS_FILE will be added to submission scripts
# before the first call to magpie-check-inputs
#
LOCAL_REQUIREMENTS=n
LOCAL_REQUIREMENTS_FILE=/tmp/mylocal

.DEFAULT_GOAL=all

all: msub-slurm-srun sbatch-srun msub-torque-pdsh lsf-mpirun

sbatch-srun:
	$(call create-templates,$@,srun)

msub-slurm-srun:
	$(call create-templates,$@,srun)

msub-torque-pdsh:
	$(call create-templates,$@,pdsh)

lsf-mpirun:
	$(call create-templates,$@,mpirun)

define common-substitution
	sed -i -e 's;MAGPIESCRIPTSDIRPREFIX;$(MAGPIE_SCRIPTS_DIR_PREFIX);g' $(1)
	sed -i -e 's;LOCALDIRPREFIX;$(LOCAL_DIR_PREFIX);g' $(1)
	sed -i -e 's;PROJECTDIRPREFIX;$(PROJECT_DIR_PREFIX);g' $(1)
	sed -i -e 's;HOMEDIRPREFIX;$(HOME_DIR_PREFIX);g' $(1)
	sed -i -e 's;LUSTREDIRPREFIX;$(LUSTRE_DIR_PREFIX);g' $(1)
	sed -i -e 's;NETWORKFSDIRPREFIX;$(NETWORKFS_DIR_PREFIX);g' $(1)
	sed -i -e 's;ZOOKEEPERDATADIRPREFIX;$(ZOOKEEPER_DATA_DIR_PREFIX);g' $(1)
	sed -i -e 's;LOCALDRIVEPREFIX;$(LOCAL_DRIVE_PREFIX);g' $(1)

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
        sed -i -e 's;HADOOPFILESYSTEMMODE;$(HADOOP_FILESYSTEM_MODE);g' $(1)
endef

define common-removals
	# User passes in string of everything they want
	if ! echo $(2) | grep -q hadoop; then \
		sed -i -e '/Run a job according to the settings of HADOOP_MODE/,+1d' $(1); \
		sed -i -e '/For Hadoop, testall will run terasort/d' $(1); \
	fi
	if ! echo $(2) | grep -q hbase; then \
		sed -i -e '/Run a job according to the settings of HBASE_MODE/,+1d' $(1); \
		sed -i -e '/For Hbase, testall will run performanceeval/d' $(1); \
	fi
	if ! echo $(2) | grep -q phoenix; then \
		sed -i -e '/Run a job according to the settings of PHOENIX_MODE/,+1d' $(1); \
		sed -i -e '/For Phoenix, testall will run performanceeval/d' $(1); \
	fi
	if ! echo $(2) | grep -q pig; then \
		sed -i -e '/Run a job according to the settings of PIG_MODE/,+1d' $(1); \
		sed -i -e '/For Pig, testall will run testpig/d' $(1); \
	fi
	if ! echo $(2) | grep -q mahout; then \
		sed -i -e '/Run a job according to the settings of MAHOUT_MODE/,+1d' $(1); \
		sed -i -e '/For Mahout, testall will run clustersyntheticcontrol/d' $(1); \
	fi
	if ! echo $(2) | grep -q spark; then \
		sed -i -e '/Run a job according to the settings of SPARK_MODE/,+1d' $(1); \
		sed -i -e '/For Spark, testall will run sparkpi/d' $(1); \
	fi
	if ! echo $(2) | grep -q kafka; then \
		sed -i -e '/Run a job according to the settings of KAFKA_MODE/,+1d' $(1); \
		sed -i -e '/For Kafka, testall will run performance/d' $(1); \
	fi
	if ! echo $(2) | grep -q zeppelin; then \
		sed -i -e '/Run a job according to the settings of ZEPPELIN_MODE/,+1d' $(1); \
	fi
	if ! echo $(2) | grep -q storm; then \
		sed -i -e '/Run a job according to the settings of STORM_MODE/,+1d' $(1); \
		sed -i -e '/For Storm, testall will run stormwordcount/d' $(1); \
	fi
	if ! echo $(2) | grep -q tachyon; then \
		sed -i -e '/Run a job according to the settings of TACHYON_MODE/,+1d' $(1); \
		sed -i -e '/For tachyon, testall will run testtachyon/d' $(1); \
	fi
	if ! echo $(2) | grep -q zookeeper; then \
		sed -i -e '/Run a job according to the settings of ZOOKEEPER_MODE/,+1d' $(1); \
		sed -i -e '/For Zookeeper, testall will run zookeeperruok/d' $(1); \
	fi
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
		sed -i -e "/@PATH_INTELLUSTRE@/{r magpie-hadoop-filesystem-path-intellustre" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_INTELLUSTRE@/{r magpie-hadoop-filesystem-config-intellustre" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_INTELLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_INTELLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_INTELLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

	if test "${INSERT_MAGPIENETWORKFS}" = "y"; then \
		sed -i -e "/@MODE_MAGPIENETWORKFS@/{r magpie-hadoop-filesystem-mode-magpienetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_MAGPIENETWORKFS@/{r magpie-hadoop-filesystem-path-magpienetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_MAGPIENETWORKFS@/{r magpie-hadoop-filesystem-config-magpienetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_MAGPIENETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_MAGPIENETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@CONFIG_MAGPIENETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

	if test "${INSERT_HDFSOVERLUSTRE}" = "y"; then \
		sed -i -e "/@MODE_HDFSOVERLUSTRE@/{r magpie-hadoop-filesystem-mode-hdfsoverlustre" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_HDFSOVERLUSTRE@/{r magpie-hadoop-filesystem-path-hdfsoverlustre" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_HDFSOVERLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_HDFSOVERLUSTRE@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

	if test "${INSERT_HDFSOVERNETWORKFS}" = "y"; then \
		sed -i -e "/@MODE_HDFSOVERNETWORKFS@/{r magpie-hadoop-filesystem-mode-hdfsovernetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_HDFSOVERNETWORKFS@/{r magpie-hadoop-filesystem-path-hdfsovernetworkfs" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@MODE_HDFSOVERNETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
		sed -i -e "/@PATH_HDFSOVERNETWORKFS@/,+1d" magpie-hadoop-filesystem-substitution; \
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
	$(eval MAGPIE_SPARK_WITH_TACHYON_AND_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-tachyon-and-hdfs)
	$(eval MAGPIE_STORM := ../script-$(SCHED)/magpie.$(SCHED)-storm)
	cp magpie-header $(MAGPIE)

	# All configuration
	echo "Creating magpie.$(SCHED)"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-terasort \
		magpie-hadoop-mode-details > $(MAGPIE)

		if test "${UDA_INCLUDE}" = "y"; then \
			cat magpie-uda >> $(MAGPIE); \
		fi

	cat	magpie-pig >> $(MAGPIE)

		if test "${MAHOUT_INCLUDE}" = "y"; then \
			cat magpie-mahout >> $(MAGPIE); \
			$(eval mahoutinclude := mahout) \
		fi


	cat	magpie-hbase >> $(MAGPIE)

		if test "${PHOENIX_INCLUDE}" = "y"; then \
			cat magpie-phoenix >> $(MAGPIE); \
			$(eval phoenixinclude := phoenix) \
		fi

	cat	magpie-spark >> $(MAGPIE)

		if test "${KAFKA_INCLUDE}" = "y"; then \
			cat magpie-kafka >> $(MAGPIE); \
			$(eval kafkainclude := kafka) \
		fi

		if test "${ZEPPELIN_INCLUDE}" = "y"; then \
			cat magpie-zeppelin >> $(MAGPIE); \
			$(eval zeppelininclude := zeppelin) \
		fi

		if test "${STORM_INCLUDE}" = "y"; then \
			cat magpie-storm >> $(MAGPIE); \
			$(eval storminclude := storm) \
		fi

		if test "${TACHYON_INCLUDE}" = "y"; then \
			cat magpie-tachyon >> $(MAGPIE); \
			$(eval tachyoninclude := tachyon) \
		fi

	cat	magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) >> $(MAGPIE)
	$(call common-substitution, ${MAGPIE})
	$(eval toincludeflags := ${mahoutinclude} ${phoenixinclude} ${kafkainclude} ${zeppelininclude} ${storminclude} ${tachyoninclude})
	$(call common-removals, ${MAGPIE}, hadoop pig spark hbase zookeeper ${toincludeflags})

	# Just Hadoop
	echo "Creating magpie.$(SCHED)-hadoop"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-terasort \
		magpie-hadoop-mode-details \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP)
	$(call common-substitution, ${MAGPIE_HADOOP})
	$(call common-removals, ${MAGPIE_HADOOP}, hadoop)

	# Hadoop with UDA
	echo "Creating magpie.$(SCHED)-hadoop-with-uda"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core magpie-hadoop-job \
		magpie-hadoop-job-details \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-terasort \
		magpie-hadoop-mode-details \
		magpie-uda \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP_WITH_UDA)
	$(call common-substitution, ${MAGPIE_HADOOP_WITH_UDA})
	$(call common-removals, ${MAGPIE_HADOOP_WITH_UDA}, hadoop)

	# Hadoop and Pig
	echo "Creating magpie.$(SCHED)-hadoop-and-pig"
	cat 	magpie-header \
		magpie-$(SCHED) \
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
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/PIG_SETUP=.*/PIG_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"pig\"/" $(MAGPIE_HADOOP_AND_PIG)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_PIG})
	$(call common-removals, ${MAGPIE_HADOOP_AND_PIG}, hadoop pig)

	# Hadoop and Mahout
	echo "Creating magpie.$(SCHED)-hadoop-and-mahout"
	cat 	magpie-header \
		magpie-$(SCHED) \
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
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/MAHOUT_SETUP=.*/MAHOUT_SETUP=yes/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"mahout\"/" $(MAGPIE_HADOOP_AND_MAHOUT)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_MAHOUT})
	$(call common-removals, ${MAGPIE_HADOOP_AND_MAHOUT}, hadoop mahout)

	# Hbase with HDFS
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-hbase \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HBASE_SETUP=.*/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"hbase\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS})
	$(call common-removals, ${MAGPIE_HBASE_WITH_HDFS}, hadoop hbase zookeeper)

	# Hbase with HDFS with Phoenix
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs-with-phoenix"
	cat 	magpie-header \
		magpie-$(SCHED) \
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
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HBASE_SETUP=.*/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/PHOENIX_SETUP=.*/PHOENIX_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"phoenix\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX})
	$(call common-removals, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX}, hadoop hbase phoenix zookeeper)

	# Spark
	echo "Creating magpie.$(SCHED)-spark"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR/export SPARK_LOCAL_SCRATCH_DIR/g" $(MAGPIE_SPARK)
	$(call common-substitution, ${MAGPIE_SPARK})
	$(call common-removals, ${MAGPIE_SPARK}, spark)

	# Spark with HDFS
	echo "Creating magpie.$(SCHED)-spark-with-hdfs"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-spark \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_HDFS})
	$(call common-removals, ${MAGPIE_SPARK_WITH_HDFS}, hadoop spark)

	# Spark with Tachyon and HDFS
	echo "Creating magpie.$(SCHED)-spark-with-tachyon-and-hdfs"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-hadoop-core \
		magpie-hadoop-job \
		magpie-hadoop-filesystem-substitution \
		magpie-hadoop-mode-details \
		magpie-spark \
		magpie-tachyon \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP=.*/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/SPARK_SETUP=.*/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/TACHYON_SETUP=.*/TACHYON_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"\(.*\)\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_TACHYON_AND_HDFS})
	$(call common-removals, ${MAGPIE_SPARK_WITH_TACHYON_AND_HDFS}, hadoop spark tachyon)

	# Storm
	echo "Creating magpie.$(SCHED)-storm"
	cat 	magpie-header \
		magpie-$(SCHED) \
		magpie-magpie-customizations-substitution \
		magpie-general-configuration \
		magpie-storm \
		magpie-zookeeper \
		magpie-run-job-header-substitution \
		magpie-run-job-$(DIST) > $(MAGPIE_STORM)
	sed -i -e "s/STORM_SETUP=.*/STORM_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_SETUP=.*/ZOOKEEPER_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"\(.*\)\"/MAGPIE_JOB_TYPE=\"storm\"/" $(MAGPIE_STORM)
	$(call common-substitution, ${MAGPIE_STORM})
	$(call common-removals, ${MAGPIE_STORM}, storm zookeeper)
endef

