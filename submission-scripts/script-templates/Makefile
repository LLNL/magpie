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
SSD_DIR_PREFIX=/ssd/$${USER}

REMOTE_CMD_DEFAULT=ssh

JAVA_DEFAULT=/usr/lib/jvm/jre-1.7.0-oracle.x86_64/

HADOOP_FILESYSTEM_MODE="hdfsoverlustre"

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
	sed -i -e 's;SSDDIRPREFIX;$(SSD_DIR_PREFIX);g' $(1)

	sed -i -e 's;REMOTECMDDEFAULT;$(REMOTE_CMD_DEFAULT);g' $(1)
	if test "${REMOTE_CMD_DEFAULT}" != "ssh"; then \
		sed -i -e "s/^# export MAGPIE_REMOTE_CMD/export MAGPIE_REMOTE_CMD/g" $(1); \
	fi
	sed -i -e 's;JAVADEFAULT;$(JAVA_DEFAULT);g' $(1)
        sed -i -e 's;HADOOPFILESYSTEMMODE;\"$(HADOOP_FILESYSTEM_MODE)\";g' $(1)
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
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution magpie-hadoop-mode-details\
		magpie-uda\
		magpie-pig\
		magpie-hbase\
                magpie-phoenix\
		magpie-spark\
		magpie-storm\
		magpie-tachyon\
		magpie-zookeeper\
		magpie-run-job-header-substitution\
		magpie-run-job-$(DIST) > $(MAGPIE)
	$(call common-substitution, ${MAGPIE})

	# Just Hadoop
	echo "Creating magpie.$(SCHED)-hadoop"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution magpie-hadoop-mode-details\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_HADOOP)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP)
	$(call common-substitution, ${MAGPIE_HADOOP})

	# Hadoop with UDA
	echo "Creating magpie.$(SCHED)-hadoop-with-uda"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution magpie-hadoop-mode-details\
		magpie-uda\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP_WITH_UDA)
	$(call common-substitution, ${MAGPIE_HADOOP_WITH_UDA})

	# Hadoop and Pig
	echo "Creating magpie.$(SCHED)-hadoop-and-pig"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution\
		magpie-pig\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"pig\"/" $(MAGPIE_HADOOP_AND_PIG)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_PIG})

	# Hadoop and Mahout
	echo "Creating magpie.$(SCHED)-hadoop-and-mahout"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution\
		magpie-mahout\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"launch\"/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/MAHOUT_SETUP=no/MAHOUT_SETUP=yes/" $(MAGPIE_HADOOP_AND_MAHOUT)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"mahout\"/" $(MAGPIE_HADOOP_AND_MAHOUT)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_MAHOUT})

	# Hbase with HDFS
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-filesystem-substitution\
		magpie-hbase\
		magpie-zookeeper\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hbase\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS})

	# Hbase with HDFS with Phoenix
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs-with-phoenix"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-filesystem-substitution\
		magpie-hbase\
                magpie-phoenix\
		magpie-zookeeper\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/PHOENIX_SETUP=no/PHOENIX_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"phoenix\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS_WITH_PHOENIX})

	# Spark
	echo "Creating magpie.$(SCHED)-spark"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-spark\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_SPARK)
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" $(MAGPIE_SPARK)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR/export SPARK_LOCAL_SCRATCH_DIR/g" $(MAGPIE_SPARK)
	sed -i -e "s/^# export SPARK_LOCAL_SCRATCH_DIR_TYPE/export SPARK_LOCAL_SCRATCH_DIR_TYPE/g" $(MAGPIE_SPARK)
	$(call common-substitution, ${MAGPIE_SPARK})

	# Spark with HDFS
	echo "Creating magpie.$(SCHED)-spark-with-hdfs"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-filesystem-substitution\
		magpie-spark\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_HDFS})

	# Spark with Tachyon and HDFS
	echo "Creating magpie.$(SCHED)-spark-with-tachyon-and-hdfs"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-filesystem-substitution\
		magpie-spark\
		magpie-tachyon\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/TACHYON_SETUP=no/TACHYON_SETUP=yes/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_TACHYON_AND_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_TACHYON_AND_HDFS})

	# Storm
	echo "Creating magpie.$(SCHED)-storm"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations-substitution magpie-general-configuration\
		magpie-storm\
		magpie-zookeeper\
		magpie-run-job-header-substitution magpie-run-job-$(DIST) > $(MAGPIE_STORM)
	sed -i -e "s/STORM_SETUP=no/STORM_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"storm\"/" $(MAGPIE_STORM)
	$(call common-substitution, ${MAGPIE_STORM})
endef

