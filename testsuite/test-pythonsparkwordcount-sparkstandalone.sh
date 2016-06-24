#!/bin/bash

cd $SPARK_HOME
bin/pyspark ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pythonsparkwordcount.py spark://${SPARK_MASTER_NODE}:${SPARK_MASTER_PORT} ${MAGPIE_SCRIPTS_HOME}/testsuite/test-wordcountfile
