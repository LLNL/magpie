# Filenames
MAGPIE_SBATCH="../script-sbatch/magpie.sbatch"
MAGPIE_SBATCH_HADOOP="../script-sbatch/magpie.sbatch-hadoop"
MAGPIE_SBATCH_HADOOP_WITH_UDA="../script-sbatch/magpie.sbatch-hadoop-with-uda"
MAGPIE_SBATCH_HADOOP_AND_PIG="../script-sbatch/magpie.sbatch-hadoop-and-pig"
MAGPIE_SBATCH_HBASE_WITH_HDFS="../script-sbatch/magpie.sbatch-hbase-with-hdfs"
MAGPIE_SBATCH_SPARK="../script-sbatch/magpie.sbatch-spark"
MAGPIE_SBATCH_SPARK_WITH_HDFS="../script-sbatch/magpie.sbatch-spark-with-hdfs"
MAGPIE_SBATCH_STORM="../script-sbatch/magpie.sbatch-storm"

MAGPIE_MSUB_SLURM="../script-msub-slurm/magpie.msub-slurm"
MAGPIE_MSUB_SLURM_HADOOP="../script-msub-slurm/magpie.msub-slurm-hadoop"
MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA="../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda"
MAGPIE_MSUB_SLURM_HADOOP_AND_PIG="../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig"
MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS="../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs"
MAGPIE_MSUB_SLURM_SPARK="../script-msub-slurm/magpie.msub-slurm-spark"
MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS="../script-msub-slurm/magpie.msub-slurm-spark-with-hdfs"
MAGPIE_MSUB_SLURM_STORM="../script-msub-slurm/magpie.msub-slurm-storm"

# Creation options, set to y or n
#
# INSERT_INTELLUSTRE - insert intellustre configuration
#
# INSERT_MAGPIENETWORKFS - insert magpienetworkfs configuration
#
INSERT_INTELLUSTRE=n
INSERT_MAGPIENETWORKFS=n
INSERT_HDFS_FEDERATION=n

all:
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

	if test "${INSERT_HDFS_FEDERATION}" = "y"; then \
		sed -i -e "/@HDFS_FEDERATION@/{r magpie-hadoop-filesystem-hdfs-federation" -e "d}" magpie-hadoop-filesystem-substitution; \
	else \
		sed -i -e "/@HDFS_FEDERATION@/,+1d" magpie-hadoop-filesystem-substitution; \
	fi

# Make sbatch with all configuration
	echo "Creating magpie.sbatch"
	cp magpie-header ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-sbatch >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-hadoop-core >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-hadoop-job >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-hadoop-mode-details >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-uda >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-pig >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-hbase >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-spark >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-storm >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-zookeeper >> ${MAGPIE_SBATCH}
	echo "" >> ${MAGPIE_SBATCH}
	cat magpie-run-job >> ${MAGPIE_SBATCH}

# Make sbatch with just Hadoop
	echo "Creating magpie.sbatch-hadoop"
	cp magpie-header ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-hadoop-core >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-hadoop-job >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-hadoop-mode-details >> ${MAGPIE_SBATCH_HADOOP}
	echo "" >> ${MAGPIE_SBATCH_HADOOP}
	cat magpie-run-job >> ${MAGPIE_SBATCH_HADOOP}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_SBATCH_HADOOP}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" ${MAGPIE_SBATCH_HADOOP}

# Make sbatch with Hadoop with UDA
	echo "Creating magpie.sbatch-hadoop-with-uda"
	cp magpie-header ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-hadoop-core >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-hadoop-job >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-hadoop-mode-details >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-uda >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	cat magpie-run-job >> ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_SBATCH_HADOOP_WITH_UDA}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" ${MAGPIE_SBATCH_HADOOP_WITH_UDA}

# Make sbatch with Hadoop and Pig
	echo "Creating magpie.sbatch-hadoop-and-pig"
	cp magpie-header ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-hadoop-core >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-hadoop-job >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-pig >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	cat magpie-run-job >> ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" ${MAGPIE_SBATCH_HADOOP_AND_PIG}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"pig\"/" ${MAGPIE_SBATCH_HADOOP_AND_PIG}

# Make sbatch with Hbase with HDFS
	echo "Creating magpie.sbatch-hbase-with-hdfs"
	cp magpie-header ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-hadoop-core >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-hbase >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-zookeeper >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	cat magpie-run-job >> ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hbase\"/" ${MAGPIE_SBATCH_HBASE_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" ${MAGPIE_SBATCH_HBASE_WITH_HDFS}

# Make sbatch with Spark
	echo "Creating magpie.sbatch-spark"
	cp magpie-header ${MAGPIE_SBATCH_SPARK}
	echo "" >> ${MAGPIE_SBATCH_SPARK}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_SPARK}
	echo "" >> ${MAGPIE_SBATCH_SPARK}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_SPARK}
	echo "" >> ${MAGPIE_SBATCH_SPARK}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_SPARK}
	echo "" >> ${MAGPIE_SBATCH_SPARK}
	cat magpie-spark >> ${MAGPIE_SBATCH_SPARK}
	echo "" >> ${MAGPIE_SBATCH_SPARK}
	cat magpie-run-job >> ${MAGPIE_SBATCH_SPARK}
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" ${MAGPIE_SBATCH_SPARK}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" ${MAGPIE_SBATCH_SPARK}

# Make sbatch with Spark with HDFS
	echo "Creating magpie.sbatch-spark-with-hdfs"
	cp magpie-header ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-hadoop-core >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-spark >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	cat magpie-run-job >> ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" ${MAGPIE_SBATCH_SPARK_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" ${MAGPIE_SBATCH_SPARK_WITH_HDFS}

# Make sbatch with Storm
	echo "Creating magpie.sbatch-storm"
	cp magpie-header ${MAGPIE_SBATCH_STORM}
	echo "" >> ${MAGPIE_SBATCH_STORM}
	cat magpie-sbatch >> ${MAGPIE_SBATCH_STORM}
	echo "" >> ${MAGPIE_SBATCH_STORM}
	cat magpie-magpie-customizations >> ${MAGPIE_SBATCH_STORM}
	echo "" >> ${MAGPIE_SBATCH_STORM}
	cat magpie-general-configuration >> ${MAGPIE_SBATCH_STORM}
	echo "" >> ${MAGPIE_SBATCH_STORM}
	cat magpie-storm >> ${MAGPIE_SBATCH_STORM}
	echo "" >> ${MAGPIE_SBATCH_STORM}
	cat magpie-zookeeper >> ${MAGPIE_SBATCH_STORM}
	echo "" >> ${MAGPIE_SBATCH_STORM}
	cat magpie-run-job >> ${MAGPIE_SBATCH_STORM}
	sed -i -e "s/STORM_SETUP=no/STORM_SETUP=yes/" ${MAGPIE_SBATCH_STORM}
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" ${MAGPIE_SBATCH_STORM}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"storm\"/" ${MAGPIE_SBATCH_STORM}

# Make msub with all configuration
	echo "Creating magpie.msub-slurm"
	cp magpie-header ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-hadoop-core >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-hadoop-job >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-hadoop-mode-details >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-uda >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-pig >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-hbase >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-spark >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-storm >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-zookeeper >> ${MAGPIE_MSUB_SLURM}
	echo "" >> ${MAGPIE_MSUB_SLURM}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM}

# Make msub with just Hadoop
	echo "Creating magpie.msub-slurm-hadoop"
	cp magpie-header ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-hadoop-core >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-hadoop-job >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-hadoop-mode-details >> ${MAGPIE_MSUB_SLURM_HADOOP}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_HADOOP}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HADOOP}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" ${MAGPIE_MSUB_SLURM_HADOOP}

# Make msub with Hadoop with UDA
	echo "Creating magpie.msub-slurm-hadoop-with-uda"
	cp magpie-header ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-hadoop-core >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-hadoop-job >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-hadoop-mode-details >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-uda >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hadoop\"/" ${MAGPIE_MSUB_SLURM_HADOOP_WITH_UDA}

# Make msub with Hadoop and Pig
	echo "Creating magpie.msub-slurm-hadoop-and-pig"
	cp magpie-header ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-hadoop-core >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-hadoop-job >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-pig >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	echo "" >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"pig\"/" ${MAGPIE_MSUB_SLURM_HADOOP_AND_PIG}

# Make msub with Hbase with HDFS
	echo "Creating magpie.msub-slurm-hbase-with-hdfs"
	cp magpie-header ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-hadoop-core >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-hbase >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-zookeeper >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"hbase\"/" ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" ${MAGPIE_MSUB_SLURM_HBASE_WITH_HDFS}

# Make msub with Spark
	echo "Creating magpie.msub-slurm-spark"
	cp magpie-header ${MAGPIE_MSUB_SLURM_SPARK}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_SPARK}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_SPARK}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_SPARK}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK}
	cat magpie-spark >> ${MAGPIE_MSUB_SLURM_SPARK}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_SPARK}
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" ${MAGPIE_MSUB_SLURM_SPARK}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" ${MAGPIE_MSUB_SLURM_SPARK}

# Make msub with Spark with HDFS
	echo "Creating magpie.msub-slurm-spark-with-hdfs"
	cp magpie-header ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-hadoop-core >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-hadoop-filesystem-substitution >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-spark >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	echo "" >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	sed -i -e "s/SPARK_SETUP=no/SPARK_SETUP=yes/" ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"spark\"/" ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" ${MAGPIE_MSUB_SLURM_SPARK_WITH_HDFS}

# Make msub with Storm
	echo "Creating magpie.msub-slurm-storm"
	cp magpie-header ${MAGPIE_MSUB_SLURM_STORM}
	echo "" >> ${MAGPIE_MSUB_SLURM_STORM}
	cat magpie-msub-slurm >> ${MAGPIE_MSUB_SLURM_STORM}
	echo "" >> ${MAGPIE_MSUB_SLURM_STORM}
	cat magpie-magpie-customizations >> ${MAGPIE_MSUB_SLURM_STORM}
	echo "" >> ${MAGPIE_MSUB_SLURM_STORM}
	cat magpie-general-configuration >> ${MAGPIE_MSUB_SLURM_STORM}
	echo "" >> ${MAGPIE_MSUB_SLURM_STORM}
	cat magpie-storm >> ${MAGPIE_MSUB_SLURM_STORM}
	echo "" >> ${MAGPIE_MSUB_SLURM_STORM}
	cat magpie-zookeeper >> ${MAGPIE_MSUB_SLURM_STORM}
	echo "" >> ${MAGPIE_MSUB_SLURM_STORM}
	cat magpie-run-job >> ${MAGPIE_MSUB_SLURM_STORM}
	sed -i -e "s/STORM_SETUP=no/STORM_SETUP=yes/" ${MAGPIE_MSUB_SLURM_STORM}
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" ${MAGPIE_MSUB_SLURM_STORM}
	sed -i -e "s/MAGPIE_JOB_TYPE=\"script\"/MAGPIE_JOB_TYPE=\"storm\"/" ${MAGPIE_MSUB_SLURM_STORM}

