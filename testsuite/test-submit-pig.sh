#!/bin/bash

source test-common.sh

SubmitPigStandardTests_Common() {
    local pigversion=$1
    local hadoopversion=$2

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
	    for hadoopversion in ${pighadoop24java16versions_hadoopversion}
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    
	for pigversion in ${pighadoop26java16versions}
	do
	    for hadoopversion in ${pighadoop26java16versions_hadoopversion}
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    
	for pigversion in ${pighadoop27java17versions}
	do
	    for hadoopversion in ${pighadoop27java17versions_hadoopversion}
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    done
}

SubmitPigDependencyTests_Dependency1() {
    local pigversion=$1
    local hadoopversion=$2

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
	    for hadoopversion in ${pighadoop24java16versions_hadoopversion}
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
	
	for pigversion in ${pighadoop26java16versions}
	do
	    for hadoopversion in ${pighadoop26java16versions_hadoopversion}
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done

	for pigversion in ${pighadoop27java17versions}
	do
	    for hadoopversion in ${pighadoop27java17versions_hadoopversion}
	    do
		${testfunction} ${pigversion} ${hadoopversion}
	    done
	done
    done
}