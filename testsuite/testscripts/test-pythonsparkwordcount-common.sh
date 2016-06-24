#!/bin/bash

# first argument is master target
cd $SPARK_HOME
if echo ${SPARK_VERSION} | grep -q -E "2\.[0-9]\.[0-9]"
then
    command="bin/spark-submit"
else
    command="bin/pyspark"
fi
${command} ${MAGPIE_SCRIPTS_HOME}/testsuite/test-pythonsparkwordcount.py $1 ${MAGPIE_SCRIPTS_HOME}/testsuite/test-wordcountfile
