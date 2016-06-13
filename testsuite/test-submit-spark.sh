#!/bin/sh

SubmitSparkStandardTests_BasicTests() {
    sparkversion=$1
    hadoopversion=$2 #unused in this function
    localdirtests=$3

    BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi
    BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-pysparkwordcount

    if [ "${localdirtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-sparkpi-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-spark-${sparkversion}-run-pysparkwordcount-no-local-dir
    fi
}

SubmitSparkStandardTests_WordCount() {
    sparkversion=$1
    hadoopversion=$2
    localdirtests=$3

    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-sparkwordcount-copy-in

    if [ "${localdirtests}" == "y" ]
    then
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsoverlustre-run-sparkwordcount-copy-in-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-spark-${sparkversion}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in-no-local-dir
	BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-spark-${sparkversion}-run-sparkwordcount-copy-in-no-local-dir
    fi
}

SubmitSparkStandardTests() {
    for testfunction in SubmitSparkStandardTests_BasicTests SubmitSparkStandardTests_WordCount
    do
	for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
	do
	    for hadoopversion in 2.2.0
	    do
		${testfunction} ${sparkversion} ${hadoopversion} "n"
	    done
	done
    
	for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
	do
	    for hadoopversion in 2.4.0
	    do
		${testfunction} ${sparkversion} ${hadoopversion} "y"
	    done
	done
    
	for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
	do
	    for hadoopversion in 2.6.0
	    do
		${testfunction} ${sparkversion} ${hadoopversion} "y"
	    done
	done
    done
}

SubmitSparkDependencyTests_Dependency1HDFS() {
    sparkversion=$1
    hadoopversion=$2
    decommission=$3

    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-copy-in
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    if [ "${decommission}" == "y" ]
    then
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    fi

    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-copy-in
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    if [ "${decommission}" == "y" ]
    then
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark1A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    fi
}

SubmitSparkDependencyTests_Dependency2HDFS() {
    sparkversion=$1
    hadoopversion=$2
    decommission=$3
    
    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-copy-in
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    if [ "${decommission}" == "y" ]
    then
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsoverlustre-decommissionhdfsnodes
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsoverlustre-run-sparkwordcount-no-copy
    fi

    BasicJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-copy-in
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    if [ "${decommission}" == "y" ]
    then
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfs-more-nodes-hdfsovernetworkfs-decommissionhdfsnodes
	DependentJobSubmit magpie.${submissiontype}-spark-with-hdfs-DependencySpark2A-hadoop-${hadoopversion}-spark-${sparkversion}-hdfsovernetworkfs-run-sparkwordcount-no-copy
    fi
}

SubmitSparkDependencyTests_Dependency3rawnetworkfs() {
    sparkversion=$1

    BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-run-sparkwordcount-copy-in
    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark3A-spark-${sparkversion}-run-sparkwordcount-no-copy
}

SubmitSparkDependencyTests_Dependency4rawnetworkfs() {
    sparkversion=$1

    BasicJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-copy-in
    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}-rawnetworkfs-more-nodes-run-sparkwordcount-no-copy
    DependentJobSubmit magpie.${submissiontype}-spark-with-rawnetworkfs-DependencySpark4A-spark-${sparkversion}-run-sparkwordcount-no-copy
}

SubmitSparkDependencyTests() {
    for testfunction in SubmitSparkDependencyTests_Dependency1HDFS SubmitSparkDependencyTests_Dependency2HDFS
    do
	for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2
	do
	    for hadoopversion in 2.2.0
	    do
		${testfunction} ${sparkversion} ${hadoopversion} "n"
	    done
	done

	for sparkversion in 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
	do
	    for hadoopversion in 2.4.0
	    do
		${testfunction} ${sparkversion} ${hadoopversion} "y"
	    done
	done

	for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
	do
	    for hadoopversion in 2.6.0
	    do
		${testfunction} ${sparkversion} ${hadoopversion} "y"
	    done
	done
    done

    for testfunction in SubmitSparkDependencyTests_Dependency3rawnetworkfs SubmitSparkDependencyTests_Dependency4rawnetworkfs
    do
	for sparkversion in 0.9.1-bin-hadoop2 0.9.2-bin-hadoop2 1.2.0-bin-hadoop2.4 1.2.1-bin-hadoop2.4 1.2.2-bin-hadoop2.4 1.3.0-bin-hadoop2.4 1.3.1-bin-hadoop2.4
	do
	    ${testfunction} ${sparkversion}
	done
	
	for sparkversion in 1.4.0-bin-hadoop2.6 1.4.1-bin-hadoop2.6 1.5.0-bin-hadoop2.6 1.5.1-bin-hadoop2.6 1.5.2-bin-hadoop2.6 1.6.0-bin-hadoop2.6 1.6.1-bin-hadoop2.6
	do
	    ${testfunction} ${sparkversion}
	done
    done
}
