#!/bin/sh

version="1.0"
distdir=magpie-${version}
tarball=${distdir}.tar.gz

rm -rf ${distdir}
rm -rf ${tarball}
mkdir ${distdir}

cp -a --parents \
    COPYING \
    DISCLAIMER \
    README \
    TODO \
    hadoop-example-environment-extra \
    hadoop-example-job \
    hadoop-example-post-job \
    hadoop-example-pre-job \
    hadoop-expand-nodes \
    hadoop-gather \
    hadoop-post-run \
    hadoop-run \
    sbatch.hadoop \
    conf/core-site-1.0.xml \
    conf/core-site-2.0.xml \
    conf/hdfs-site-1.0.xml \
    conf/hdfs-site-2.0.xml \
    conf/mapred-site-1.0.xml \
    conf/mapred-site-2.0.xml \
    conf/yarn-env-2.0.sh \
    conf/hadoop-env-1.0.sh \
    conf/hadoop-env-2.0.sh \
    conf/yarn-site-2.0.xml \
    conf/log4j.properties \
    patches/hadoop-1.2.1-9109.patch \
    patches/hadoop-2.1.0-beta-9109.patch \
    ${distdir}

tar czf ${tarball} ${distdir}
rm -rf ${distdir}
