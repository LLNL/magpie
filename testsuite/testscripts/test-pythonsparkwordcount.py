from __future__ import print_function

import os
import sys

from pyspark import SparkContext
from pyspark import SparkConf

conf = SparkConf()

sparkmaster=sys.argv[1]
wordcountfile=sys.argv[2]

conf.setMaster(sparkmaster)
conf.setAppName("test")

sc = SparkContext(conf = conf)

file = sc.textFile(wordcountfile)

counts = file.flatMap(lambda line: line.split(" ")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)

output = counts.collect()

for (k, v) in output:
    print(k + ": " + str(v))
