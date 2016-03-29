#!/bin/sh

SubmitHadoopStandardTests() {
    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
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

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort
    done
    
    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
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

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-largeperformancerun-run-hadoopterasort
    done
}

SubmitHadoopDependencyTests() {
    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsoverlustre-run-hadoopterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-DependencyHadoop1A-hadoop-${hadoopversion}-hdfsovernetworkfs-run-hadoopterasort
    done

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsoverlustre-run-hadoopterasort

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsovernetworkfs-hdfs-older-version-expected-failure
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopupgradehdfs
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop2A-hdfsovernetworkfs-run-hadoopterasort

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort


	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsoverlustre-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsoverlustre-run-hadoopterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-hdfsovernetworkfs-run-hadoopterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop3A-hdfsovernetworkfs-run-hadoopterasort
    done

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4A-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4A-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop4B-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.2.0-DependencyHadoop4B-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5A-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5A-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop5B-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.3.0-DependencyHadoop5B-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6A-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6A-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop6B-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.4.0-DependencyHadoop6B-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7A-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7A-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop7B-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.5.0-DependencyHadoop7B-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8A-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8A-hdfs-newer-version-expected-failure

    BasicJobSubmit magpie.${submissiontype}-hadoop-2.7.0-DependencyHadoop8B-run-hadoopterasort
    DependentJobSubmit magpie.${submissiontype}-hadoop-2.6.0-DependencyHadoop8B-hdfs-newer-version-expected-failure

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsoverlustre-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsoverlustre-run-scriptterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-fewer-nodes-hdfsovernetworkfs-expected-failure
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop9A-hdfsovernetworkfs-run-scriptterasort
    done

    for hadoopversion in 2.2.0 2.3.0 2.4.0 2.4.1 2.5.0 2.5.1 2.5.2 2.6.0 2.6.1 2.6.2 2.6.3 2.6.4
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsoverlustre-run-scriptterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsovernetworkfs-run-scriptterasort
    done

    for hadoopversion in 2.7.0 2.7.1 2.7.2
    do
	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsoverlustre-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsoverlustre
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsoverlustre-run-scriptterasort

	BasicJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptteragen
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-hdfsovernetworkfs-run-scriptterasort
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfs-more-nodes-decommissionhdfsnodes-hdfsovernetworkfs
	DependentJobSubmit magpie.${submissiontype}-hadoop-${hadoopversion}-DependencyHadoop10A-hdfsovernetworkfs-run-scriptterasort
    done
}