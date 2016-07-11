#!/bin/bash

# Job Submission Config

# Note msub-torque-pdsh not done yet

#submissiontype=lsf-mpirun
#submissiontype=msub-slurm-srun
#submissiontype=msub-torque-pdsh 
submissiontype=sbatch-srun

msubslurmsrunpartition=mycluster
msubslurmsrunbatchqueue=pbatch

sbatchsrunpartition=pc6220

lsfqueue=standard

# Test config
#
# base node counts for job submission
#
# base node count of 8 means most jobs will be job size of 9, the
# additional 1 will be added later for the master.
#
# zookeepernodecount will be added when necessary
basenodecount=8
zookeepernodecount=3

# Don't edit these, calculated based on the above
basenodeszookeepernodesmorenodescount=`expr ${basenodecount} \* 2 + ${zookeepernodecount} + 1`
basenodesmorenodescount=`expr ${basenodecount} \* 2 + 1`
basenodeszookeepernodescount=`expr ${basenodecount} + ${zookeepernodecount} + 1`
basenodescount=`expr ${basenodecount} + 1`
