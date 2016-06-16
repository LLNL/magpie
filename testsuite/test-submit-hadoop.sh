#!/bin/bash

SubmitHadoopStandardTests_StandardTerasort() {
    hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsondisk-multiple-paths-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-single-path-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsoverlustre-localstore-multiple-paths-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-single-path-run-hadoopterasort-no-local-dir
    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-hdfsovernetworkfs-localstore-multiple-paths-run-hadoopterasort-no-local-dir
}

SubmitHadoopStandardTests() {
    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	SubmitHadoopStandardTests_StandardTerasort ${hadoopversion}
    done
    
    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	SubmitHadoopStandardTests_StandardTerasort ${hadoopversion}
    done
}

SubmitHadoopDependencyTests_Dependency1() {
    hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
}

SubmitHadoopDependencyTests_Dependency2() {
    hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
}

SubmitHadoopDependencyTests_Dependency3() {
    hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-scriptterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-scriptterasort
}

SubmitHadoopDependencyTests_Dependency4() {
    hadoopversion=$1

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsoverlustre-run-scriptterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop4A-hdfsovernetworkfs-run-scriptterasort
}

SubmitHadoopDependencyTests_DependencyDetectNewerHDFS() {
    hadoopversionold=$1
    hadoopversionnew=$2
    dependencynumber=$3

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsoverlustre-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionnew}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversionold}-DependencyHadoop${dependencynumber}-hdfsovernetworkfs-hdfs-newer-version-expected-failure
}

SubmitHadoopDependencyTests() {
    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	SubmitHadoopDependencyTests_Dependency1 ${hadoopversion}
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	SubmitHadoopDependencyTests_Dependency1 ${hadoopversion}
    done

    for testfunction in SubmitHadoopDependencyTests_Dependency2 SubmitHadoopDependencyTests_Dependency3 SubmitHadoopDependencyTests_Dependency4
    do
	for hadoopversion in 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
	do
	    ${testfunction} ${hadoopversion}
	done

	for hadoopversion in 2.7.0 2.7.1 2.7.2
	do
	    ${testfunction} ${hadoopversion}
	done
    done


    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop5A-hdfsovernetworkfs-run-hadoopterasort

    SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.2.0" "2.3.0" "6A"
    SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.3.0" "2.4.0" "7A"
    SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.4.0" "2.5.0" "8A"
    SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.5.0" "2.6.0" "9A"
    SubmitHadoopDependencyTests_DependencyDetectNewerHDFS "2.6.0" "2.7.0" "10A"
}