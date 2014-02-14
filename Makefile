all:
# Make sbatch with all configuration
	echo "Creating magpie.sbatch"
	cp templates/magpie-header magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-sbatch >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-magpie-customizations >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-general-configuration >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-hadoop >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-uda >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-pig >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-zookeeper >> magpie.sbatch
	echo "" >> magpie.sbatch
	cat templates/magpie-run-job >> magpie.sbatch

# Make sbatch with just Hadoop
	echo "Creating magpie.sbatch-hadoop"
	cp templates/magpie-header magpie.sbatch-hadoop
	echo "" >> magpie.sbatch-hadoop
	cat templates/magpie-sbatch >> magpie.sbatch-hadoop
	echo "" >> magpie.sbatch-hadoop
	cat templates/magpie-magpie-customizations >> magpie.sbatch-hadoop
	echo "" >> magpie.sbatch-hadoop
	cat templates/magpie-general-configuration >> magpie.sbatch-hadoop
	echo "" >> magpie.sbatch-hadoop
	cat templates/magpie-hadoop >> magpie.sbatch-hadoop
	echo "" >> magpie.sbatch-hadoop
	cat templates/magpie-run-job >> magpie.sbatch-hadoop
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" magpie.sbatch-hadoop

# Make sbatch with Hadoop and Pig
	echo "Creating magpie.sbatch-hadoop-and-pig"
	cp templates/magpie-header magpie.sbatch-hadoop-and-pig
	echo "" >> magpie.sbatch-hadoop-and-pig
	cat templates/magpie-sbatch >> magpie.sbatch-hadoop-and-pig
	echo "" >> magpie.sbatch-hadoop-and-pig
	cat templates/magpie-magpie-customizations >> magpie.sbatch-hadoop-and-pig
	echo "" >> magpie.sbatch-hadoop-and-pig
	cat templates/magpie-general-configuration >> magpie.sbatch-hadoop-and-pig
	echo "" >> magpie.sbatch-hadoop-and-pig
	cat templates/magpie-hadoop >> magpie.sbatch-hadoop-and-pig
	echo "" >> magpie.sbatch-hadoop-and-pig
	cat templates/magpie-pig >> magpie.sbatch-hadoop-and-pig
	echo "" >> magpie.sbatch-hadoop-and-pig
	cat templates/magpie-run-job >> magpie.sbatch-hadoop-and-pig
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" magpie.sbatch-hadoop-and-pig
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" magpie.sbatch-hadoop-and-pig

# Make msub with all configuration
	echo "Creating magpie.msub"
	cp templates/magpie-header magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-msub >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-magpie-customizations >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-general-configuration >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-hadoop >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-uda >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-pig >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-zookeeper >> magpie.msub
	echo "" >> magpie.msub
	cat templates/magpie-run-job >> magpie.msub

# Make msub with just Hadoop
	echo "Creating magpie.msub-hadoop"
	cp templates/magpie-header magpie.msub-hadoop
	echo "" >> magpie.msub-hadoop
	cat templates/magpie-msub >> magpie.msub-hadoop
	echo "" >> magpie.msub-hadoop
	cat templates/magpie-magpie-customizations >> magpie.msub-hadoop
	echo "" >> magpie.msub-hadoop
	cat templates/magpie-general-configuration >> magpie.msub-hadoop
	echo "" >> magpie.msub-hadoop
	cat templates/magpie-hadoop >> magpie.msub-hadoop
	echo "" >> magpie.msub-hadoop
	cat templates/magpie-run-job >> magpie.msub-hadoop
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" magpie.msub-hadoop

# Make msub with Hadoop and Pig
	echo "Creating magpie.msub-hadoop-and-pig"
	cp templates/magpie-header magpie.msub-hadoop-and-pig
	echo "" >> magpie.msub-hadoop-and-pig
	cat templates/magpie-msub >> magpie.msub-hadoop-and-pig
	echo "" >> magpie.msub-hadoop-and-pig
	cat templates/magpie-magpie-customizations >> magpie.msub-hadoop-and-pig
	echo "" >> magpie.msub-hadoop-and-pig
	cat templates/magpie-general-configuration >> magpie.msub-hadoop-and-pig
	echo "" >> magpie.msub-hadoop-and-pig
	cat templates/magpie-hadoop >> magpie.msub-hadoop-and-pig
	echo "" >> magpie.msub-hadoop-and-pig
	cat templates/magpie-pig >> magpie.msub-hadoop-and-pig
	echo "" >> magpie.msub-hadoop-and-pig
	cat templates/magpie-run-job >> magpie.msub-hadoop-and-pig
	sed -i -e "s/HADOOP_SETUP=no/HADOOP_SETUP=yes/" magpie.msub-hadoop-and-pig
	sed -i -e "s/PIG_SETUP=no/PIG_SETUP=yes/" magpie.msub-hadoop-and-pig
