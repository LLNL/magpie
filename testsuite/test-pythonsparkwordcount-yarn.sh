#!/bin/bash

cd $SPARK_HOME
bin/pyspark ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pythonsparkwordcount.py yarn-client ${MAGPIE_SCRIPTS_HOME}/testsuite/test-wordcountfile
