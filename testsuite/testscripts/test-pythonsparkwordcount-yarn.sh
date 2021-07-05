#!/bin/bash

if echo ${SPARK_VERSION} | grep -q -E "1\.[0-9]\.[0-9]"
then
    sparkmaster="yarn-client"
else
    sparkmaster="yarn"
fi

${MAGPIE_SCRIPTS_HOME}/testsuite/testscripts/test-pythonsparkwordcount-common.sh ${sparkmaster}
