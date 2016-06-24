#!/bin/bash

cd $SPARK_HOME
bin/pyspark ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pythonspark.py yarn-client ${MAGPIE_SCRIPTS_HOME}/testsuite/test-wordcountfile
