#!/bin/sh

cd $SPARK_HOME
bin/pyspark ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pyspark.py ${MAGPIE_SCRIPTS_HOME}/testsuite/test-wordcountfile