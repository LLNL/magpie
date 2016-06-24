#!/bin/bash

# first argument is master target
cd $SPARK_HOME
bin/pyspark ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pythonsparkwordcount.py $1 ${MAGPIE_SCRIPTS_HOME}/testsuite/test-wordcountfile
