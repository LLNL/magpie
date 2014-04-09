all:
# Make sbatch with all configuration
	echo "Creating magpie.sbatch"
	cp magpie-header ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-sbatch >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-magpie-customizations >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-general-configuration >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-hadoop >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-hadoop-mode-details >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-uda >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-pig >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-zookeeper >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-hbase >> ../script-sbatch/magpie.sbatch
	echo "" >> ../script-sbatch/magpie.sbatch
	cat magpie-run-job >> ../script-sbatch/magpie.sbatch

# Make sbatch with just Hadoop
	echo "Creating magpie.sbatch-hadoop"
	cp magpie-header ../script-sbatch/magpie.sbatch-hadoop
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop
	cat magpie-sbatch >> ../script-sbatch/magpie.sbatch-hadoop
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop
	cat magpie-magpie-customizations >> ../script-sbatch/magpie.sbatch-hadoop
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop
	cat magpie-general-configuration >> ../script-sbatch/magpie.sbatch-hadoop
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop
	cat magpie-hadoop >> ../script-sbatch/magpie.sbatch-hadoop
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop
	cat magpie-hadoop-mode-details >> ../script-sbatch/magpie.sbatch-hadoop
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop
	cat magpie-run-job >> ../script-sbatch/magpie.sbatch-hadoop
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-sbatch/magpie.sbatch-hadoop

# Make sbatch with Hadoop with UDA
	echo "Creating magpie.sbatch-hadoop-with-uda"
	cp magpie-header ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-sbatch >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-magpie-customizations >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-general-configuration >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-hadoop >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-hadoop-mode-details >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-uda >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	cat magpie-run-job >> ../script-sbatch/magpie.sbatch-hadoop-with-uda
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-sbatch/magpie.sbatch-hadoop-with-uda

# Make sbatch with Hadoop and Pig
	echo "Creating magpie.sbatch-hadoop-and-pig"
	cp magpie-header ../script-sbatch/magpie.sbatch-hadoop-and-pig
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	cat magpie-sbatch >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	cat magpie-magpie-customizations >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	cat magpie-general-configuration >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	cat magpie-hadoop >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	cat magpie-pig >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	echo "" >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	cat magpie-run-job >> ../script-sbatch/magpie.sbatch-hadoop-and-pig
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-sbatch/magpie.sbatch-hadoop-and-pig
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" ../script-sbatch/magpie.sbatch-hadoop-and-pig
	sed -i -e "s/MAGPIE_JOB_TYPE=\"hadoop\"/MAGPIE_JOB_TYPE=\"pig\"/" ../script-sbatch/magpie.sbatch-hadoop-and-pig

# Make sbatch with Hadoop and Hbase
	echo "Creating magpie.sbatch-hbase-with-hdfs"
	cp magpie-header ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-sbatch >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-magpie-customizations >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-general-configuration >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-hadoop >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-hbase >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-zookeeper >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	echo "" >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	cat magpie-run-job >> ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	sed -i -e "s/MAGPIE_JOB_TYPE=\"hadoop\"/MAGPIE_JOB_TYPE=\"hbase\"/" ../script-sbatch/magpie.sbatch-hbase-with-hdfs
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" ../script-sbatch/magpie.sbatch-hbase-with-hdfs

# Make msub with all configuration
	echo "Creating magpie.msub-slurm"
	cp magpie-header ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-msub-slurm >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-magpie-customizations >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-general-configuration >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-hadoop >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-hadoop-mode-details >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-uda >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-pig >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-zookeeper >> ../script-msub-slurm/magpie.msub-slurm
	echo "" >> ../script-msub-slurm/magpie.msub-slurm
	cat magpie-run-job >> ../script-msub-slurm/magpie.msub-slurm

# Make msub with just Hadoop
	echo "Creating magpie.msub-slurm-hadoop"
	cp magpie-header ../script-msub-slurm/magpie.msub-slurm-hadoop
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	cat magpie-msub-slurm >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	cat magpie-magpie-customizations >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	cat magpie-general-configuration >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	cat magpie-hadoop >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	cat magpie-hadoop-mode-details >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	cat magpie-run-job >> ../script-msub-slurm/magpie.msub-slurm-hadoop
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hadoop

# Make msub with Hadoop with UDA
	echo "Creating magpie.msub-slurm-hadoop-with-uda"
	cp magpie-header ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-msub-slurm >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-magpie-customizations >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-general-configuration >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-hadoop >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-hadoop-mode-details >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-uda >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	cat magpie-run-job >> ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hadoop-with-uda

# Make msub with Hadoop and Pig
	echo "Creating magpie.msub-slurm-hadoop-and-pig"
	cp magpie-header ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	cat magpie-msub-slurm >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	cat magpie-magpie-customizations >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	cat magpie-general-configuration >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	cat magpie-hadoop >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	cat magpie-pig >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	cat magpie-run-job >> ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig
	sed -i -e "s/MAGPIE_JOB_TYPE=\"hadoop\"/MAGPIE_JOB_TYPE=\"pig\"/" ../script-msub-slurm/magpie.msub-slurm-hadoop-and-pig

# Make msub with Hadoop and Hbase
	echo "Creating magpie.msub-slurm-hbase-with-hdfs"
	cp magpie-header ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-msub-slurm >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-magpie-customizations >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-general-configuration >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-hadoop >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-hbase >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-zookeeper >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	echo "" >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	cat magpie-run-job >> ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	sed -i -e "s/HBASE_SETUP=no/HBASE_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	sed -i -e "s/ZOOKEEPER_SETUP=no/ZOOKEEPER_SETUP=yes/" ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	sed -i -e "s/MAGPIE_JOB_TYPE=\"hadoop\"/MAGPIE_JOB_TYPE=\"hbase\"/" ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
	sed -i -e "s/HADOOP_SETUP_TYPE=\"MR2\"/HADOOP_SETUP_TYPE=\"HDFS2\"/" ../script-msub-slurm/magpie.msub-slurm-hbase-with-hdfs
