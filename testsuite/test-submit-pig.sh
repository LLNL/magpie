#!/bin/bash

source test-common.sh

SubmitPigStandardTests_Common() {
    pigversion=$1
    hadoopversion=$2

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript
    
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-testpig-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-hadoop-${hadoopversion}-pig-${pigversion}-run-pigscript-no-local-dir
}

SubmitPigStandardTests() {
    for testfunction in SubmitPigStandardTests_Common
    do
	for pigversion in ${pighadoop24java16versions}
	do
	    for hadoopversion in 2.4.0
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    
	for pigversion in ${pighadoop26java16versions}
	do
	    for hadoopversion in 2.6.0
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    
	for pigversion in 0.15.0
	do
	    for hadoopversion in 2.7.0
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    done
}

SubmitPigDependencyTests_Dependency1() {
    pigversion=$1
    hadoopversion=$2

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-run-pigscript
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsoverlustre-no-copy-run-pigscript

    BasicJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-testpig
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-run-pigscript
    DependentJobSubmit magpie.${submissiontype}-hadoop-and-pig-DependencyPig1A-hadoop-${hadoopversion}-pig-${pigversion}-hdfsovernetworkfs-no-copy-run-pigscript
}

SubmitPigDependencyTests() {
    for testfunction in SubmitPigDependencyTests_Dependency1
    do
	for pigversion in ${pighadoop24java16versions}
	do
	    for hadoopversion in 2.4.0
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
	
	for pigversion in ${pighadoop26java16versions}
	do
	    for hadoopversion in 2.6.0
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done

	for pigversion in ${pighadoop27java17versions}
	do
	    for hadoopversion in 2.7.0
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    done
}