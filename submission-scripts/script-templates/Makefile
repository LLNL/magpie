# Creation options, set to y or n
#
# INSERT_INTELLUSTRE - insert intellustre configuration
#
# INSERT_MAGPIENETWORKFS - insert magpienetworkfs configuration
#
# INSERT_HDFSOVERNETWORKFS - insert HDFS over NetworkFS configuration
#
# INSERT_HDFS_FEDERATION - insert HDFS federation configuration 
#
INSERT_INTELLUSTRE=n
INSERT_MAGPIENETWORKFS=n
INSERT_HDFSOVERNETWORKFS=y
INSERT_HDFS_FEDERATION=n

MAGPIE_SCRIPTS_DIR_PREFIX="/home/\\\$$\$$\{MAGPIE_USERNAME\}"
LOCAL_DIR_PREFIX="/tmp/\\\$$\$$\{MAGPIE_USERNAME\}"
PROJECT_DIR_PREFIX="/home/\\\$$\$$\{MAGPIE_USERNAME\}"
HOME_DIR_PREFIX="/home/\\\$$\$$\{MAGPIE_USERNAME\}"
LUSTRE_DIR_PREFIX="/lustre/\\\$$\$$\{MAGPIE_USERNAME\}"
NETWORKFS_DIR_PREFIX="/networkfs/\\\$$\$$\{MAGPIE_USERNAME\}"
SSD_DIR_PREFIX="/ssd/\\\$$\$$\{MAGPIE_USERNAME\}"

REMOTE_CMD_DEFAULT="ssh"

.DEFAULT_GOAL=all

all: msub-slurm sbatch msub-torque

sbatch:
	$(call create-templates,$@,srun)

msub-slurm:
	$(call create-templates,$@,srun)

msub-torque:
	$(call create-templates,$@,pdsh)

define common-substitution
	$(eval magpiescriptsdirprefix := $(shell echo "${MAGPIE_SCRIPTS_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))
	$(eval localdirprefix := $(shell echo "${LOCAL_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))
	$(eval projectdirprefix := $(shell echo "${PROJECT_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))
	$(eval homedirprefix := $(shell echo "${HOME_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))
	$(eval lustredirprefix := $(shell echo "${LUSTRE_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))
	$(eval networkfsdirprefix := $(shell echo "${NETWORKFS_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))
	$(eval ssddirprefix := $(shell echo "${SSD_DIR_PREFIX}" | sed "s/\\//\\\\\\\\\//g"))

	sed -i -e "s/MAGPIESCRIPTSDIRPREFIX/${magpiescriptsdirprefix}/g" $(1)
	sed -i -e "s/LOCALDIRPREFIX/${localdirprefix}/g" $(1)
	sed -i -e "s/PROJECTDIRPREFIX/${projectdirprefix}/g" $(1)
	sed -i -e "s/HOMEDIRPREFIX/${homedirprefix}/g" $(1)
	sed -i -e "s/LUSTREDIRPREFIX/${lustredirprefix}/g" $(1)
	sed -i -e "s/NETWORKFSDIRPREFIX/${networkfsdirprefix}/g" $(1)
	sed -i -e "s/SSDDIRPREFIX/${ssddirprefix}/g" $(1)

	sed -i -e "s/REMOTECMDDEFAULT/${REMOTE_CMD_DEFAULT}/g" $(1)
endef

define create-templates
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

	$(eval SCHED := $(1))
	$(eval DIST := $(2))
	echo "Creating magpie.$(SCHED)"
	mkdir -p ../script-$(SCHED)
	$(eval MAGPIE := ../script-$(SCHED)/magpie.$(SCHED))
	$(eval MAGPIE_HADOOP := ../script-$(SCHED)/magpie.$(SCHED)-hadoop)
	$(eval MAGPIE_HADOOP_WITH_UDA := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-with-uda)
	$(eval MAGPIE_HADOOP_AND_PIG := ../script-$(SCHED)/magpie.$(SCHED)-hadoop-and-pig)
	$(eval MAGPIE_HBASE_WITH_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-hbase-with-hdfs)
	$(eval MAGPIE_SPARK := ../script-$(SCHED)/magpie.$(SCHED)-spark)
	$(eval MAGPIE_SPARK_WITH_HDFS := ../script-$(SCHED)/magpie.$(SCHED)-spark-with-hdfs)
	$(eval MAGPIE_STORM := ../script-$(SCHED)/magpie.$(SCHED)-storm)
	cp magpie-header $(MAGPIE)

	# All configuration
	echo "Creating magpie.$(SCHED)"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution magpie-hadoop-mode-details\
		magpie-uda\
		magpie-pig\
		magpie-hbase\
		magpie-spark\
		magpie-storm\
		magpie-zookeeper\
		magpie-run-job-$(DIST) > $(MAGPIE)
	$(call common-substitution, ${MAGPIE})

	# Just Hadoop
	echo "Creating magpie.$(SCHED)-hadoop"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution magpie-hadoop-mode-details\
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP)
	$(call common-substitution, ${MAGPIE_HADOOP})

	# Hadoop with UDA
	echo "Creating magpie.$(SCHED)-hadoop-with-uda"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution magpie-hadoop-mode-details\
		magpie-uda\
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_WITH_UDA)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" $(MAGPIE_HADOOP_WITH_UDA)
	$(call common-substitution, ${MAGPIE_HADOOP_WITH_UDA})

	# Hadoop and Pig
	echo "Creating magpie.$(SCHED)-hadoop-and-pig"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-job-details magpie-hadoop-filesystem-substitution\
		magpie-pig\
		magpie-run-job-$(DIST) > $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" $(MAGPIE_HADOOP_AND_PIG)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"pig\"/" $(MAGPIE_HADOOP_AND_PIG)
	$(call common-substitution, ${MAGPIE_HADOOP_AND_PIG})

	# Hadoop with Hbase with HDFS
	echo "Creating magpie.$(SCHED)-hbase-with-hdfs"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-filesystem-substitution\
		magpie-hbase\
		magpie-zookeeper\
		magpie-run-job-$(DIST) > $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hbase\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_HBASE_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_HBASE_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_HBASE_WITH_HDFS})

	# Spark
	echo "Creating magpie.$(SCHED)-spark"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-spark\
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK)
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" $(MAGPIE_SPARK)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK)
	$(call common-substitution, ${MAGPIE_SPARK})

	# Spark with HDFS
	echo "Creating magpie.$(SCHED)-spark-with-hdfs"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-hadoop-core magpie-hadoop-job magpie-hadoop-filesystem-substitution\
		magpie-spark\
		magpie-run-job-$(DIST) > $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" $(MAGPIE_SPARK_WITH_HDFS)
	sed -i -e "s/HADOOP_MODE=\"terasort\"/HADOOP_MODE=\"hdfsonly\"/" $(MAGPIE_SPARK_WITH_HDFS)
	$(call common-substitution, ${MAGPIE_SPARK_WITH_HDFS})

	# Storm
	echo "Creating magpie.$(SCHED)-storm"
	cat 	magpie-header magpie-$(SCHED) magpie-magpie-customizations magpie-general-configuration\
		magpie-storm\
		magpie-zookeeper\
		magpie-run-job-$(DIST) > $(MAGPIE_STORM)
	sed -i -e "s/STORM_SETUP=no/STORM_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" $(MAGPIE_STORM)
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"storm\"/" $(MAGPIE_STORM)
	$(call common-substitution, ${MAGPIE_STORM})
endef

