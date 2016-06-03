from pyspark import SparkContext
from pyspark import SparkConf

import os
import sys

conf = SparkConf()

#sparkmaster="spark://" + os.environ['SPARK_MASTER_NODE'] + ":" + os.environ['SPARK_MASTER_PORT']
sparkmaster="local"
conf.setMaster(sparkmaster)
conf.setAppName("test")

sc = SparkContext(conf = conf)

wordcountfile=sys.argv[1]

file = sc.textFile(wordcountfile)

counts = file.flatMap(lambda line: line.split(" ")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)

output = counts.collect()

for (k, v) in output:
    print k + ": " + str(v)
