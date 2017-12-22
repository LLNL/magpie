#!/bin/bash

source test-common.sh
source test-config.sh

SetupSparkWordCountHDFSNoCopy() {
    local files=$@

    sed -i \
        -e 's/export SPARK_JOB="\(.*\)"/export SPARK_JOB="sparkwordcount"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"hdfs:\/\/\/user\/\${USER}\/test-wordcountfile\"/' \
        ${files}
}

SetupSparkWordCountHDFSCopyIn() {
    local files=$@

    SetupSparkWordCountHDFSNoCopy ${files}

    sed -i \
        -e 's/# export SPARK_SPARKWORDCOUNT_COPY_IN_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_COPY_IN_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        ${files}
}

SetupSparkWordCountRawNetworkFSNoCopy() {
    local files=$@

    sed -i \
        -e 's/export SPARK_JOB="\(.*\)"/export SPARK_JOB="sparkwordcount"/' \
        -e 's/# export SPARK_SPARKWORDCOUNT_FILE="\(.*\)"/export SPARK_SPARKWORDCOUNT_FILE=\"file:\/\/'"${magpiescriptshomesubst}"'\/testsuite\/testdata\/test-wordcountfile\"/' \
        ${files}
}
