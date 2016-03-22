data = LOAD '/user/achu/test-pigdata' USING PigStorage(',') AS (f1:int, f2:int, f3:int);
DESCRIBE data;
DUMP data;
