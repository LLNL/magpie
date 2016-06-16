#!/bin/bash

SubmitMahoutStandardTests_ClusterSyntheticcontrol() {
    mahoutversion=$1
    hadoopversion=$2

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol
	    
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-hadoop-${hadoopversion}-mahout-${mahoutversion}-run-clustersyntheticcontrol-no-local-dir
}

SubmitMahoutStandardTests() {
    for mahoutversion in 0.11.0 0.11.1 0.11.2 0.12.0 0.12.1
    do
	for hadoopversion in 2.7.0
	do
	    SubmitMahoutStandardTests_ClusterSyntheticcontrol ${mahoutversion} ${hadoopversion}
	done
    done
}

SubmitMahoutDependencyTests_Dependency1() {
    mahoutversion=$1
    hadoopversion=$2

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsoverlustre-run-clustersyntheticcontrol
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsoverlustre-run-clustersyntheticcontrol

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsovernetworkfs-run-clustersyntheticcontrol
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-mahout-DependencyMahout1A-hadoop-${hadoopversion}-mahout-${mahoutversion}-hdfsovernetworkfs-run-clustersyntheticcontrol
}

SubmitMahoutDependencyTests() {
    for mahoutversion in 0.11.0 0.11.1 0.11.2 0.12.0 0.12.1
    do
	for hadoopversion in 2.7.0
	do
	    SubmitMahoutDependencyTests_Dependency1 ${mahoutversion} ${hadoopversion}
	done
    done
}