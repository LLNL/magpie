Magpie
------

Magpie contains a number of scripts for running Big Data software in
HPC environments.  Thus far, Hadoop, Spark, Hbase, Storm, Pig,
Phoenix, Kafka, Zeppelin, Zookeeper, and Alluxio are supported. It
currently supports running over the parallel file system Lustre and
running over any generic network filesytem.  There is
scheduler/resource manager support for Slurm, Moab, Torque, and LSF.

Some of the features presently supported:

- Run jobs interactively or via scripts.
- Run against a number of filesystem options, such as HDFS, HDFS over
  Lustre, HDFS over a generic network filesystem, Lustre directly, or
  a generic network filesystem.
- Take advantage of SSDs/NVRAM for local caching if available
- Make decent optimizations for your hardware

Experimental support for several distributed machine learning
frameworks has also been added.  Presently tensorflow, tensorflow
w/ horovod, and ray is supported.

Basic Idea
----------

The basic idea behind these scripts are to:

1) Submit a Magpie batch script to allocate nodes on a cluster using
   your HPC scheduler/resource manager.  Slurm, Slurm+mpirun,
   Moab+Slurm, Moab+Torque and LSF+mpirun are currently supported.

2) The batch script will create configuration files for all
   appropriate projects (Hadoop, Spark, etc.)  The configuration files
   will be setup so the rank 0 node is the "master".  All compute
   nodes will have configuration files created that point to the node
   designated as the master server.

   The configuration files will be populated with values for your
   filesystem choice and the hardware that exists in your cluster.
   Reasonable attempts are made to determine optimal values for your
   system and hardware (they are almost certainly better than the
   default values).  A number of options exist in the batch scripts to
   adjust these values for individual jobs.

3) Launch daemons on all nodes.  The rank 0 node will run master
   daemons, such as the Hadoop Namenode.  All remaining nodes will run
   appropriate worker daemons, such as the Hadoop Datanodes.

4) Now you have a mini big data cluster to do whatever you want.  You
   can log into the master node and interact with your mini big data
   cluster however you want.  Or you could have Magpie run a script to
   execute your big data calculation instead.

5) When your job completes or your allocation time has run out, Magpie
   will cleanup your job by tearing down daemons.  When appropriate,
   Magpie may also do some additional cleanup work to hopefully make
   re-execution on later runs cleaner and faster.

Supported Packages & Versions
-----------------------------

For a complete list of supported package versions and dependencies,
please see ```doc/README```.  The following can be considered a
summary of support.

Hadoop - 2.2.0, 2.3.0, 2.4.X, 2.5.X, 2.6.X, 2.7.X, 2.8.X, 2.9.X,
         3.0.X, 3.1.X, 3.2.X, 3.3.X

Spark - 1.1.X, 1.2.X, 1.3.X, 1.4.X, 1.5.X, 1.6.X, 2.0.X, 2.1.X, 2.2.X,
        2.3.X, 2.4.X, 3.0.X, 3.1.X, 3.2.X

Hbase - 1.0.X, 1.1.X, 1.2.X, 1.3.X, 1.4.X, 1.5.X, 1.6.X

Hive - 2.3.0

Pig - 0.13.0, 0.14.0, 0.15.0, 0.16.0, 0.17.0

Zookeeper - 3.4.X

Storm - 0.9.X, 0.10.X, 1.0.X, 1.1.X, 1.2.X

Phoenix - 4.5.X, 4.6.0, 4.7.0, 4.8.X, 4.9.0, 4.10.1, 4.11.0, 4.12.0,
          4.13.X, 4.14.0

Kafka - 2.11-0.9.0.0

Zeppelin - 0.6.X, 0.7.X, 0.8.X

Alluxio - 2.3.0

TensorFlow - 1.9, 1.12

Ray - 0.7.0

Older Supported Packages & Features
-----------------------------------

Some packages and features were dropped due to lack of interest, the
software becoming old/deprecated, and/or their initial experimental
addition into Magpie.  If you are interested in them, please look at
older versions for supported versions and documentation.  If you are
very interested in support in current versions of Magpie beyond an
experimental nature, please submit a support request and we can
reconsider adding it back in.

Removed in Magpie 2.0

   - Hadoop 1.X support
   - Tachyon
   - UDA/uda-plugin for Hadoop
   - HDFS Federation in Hadoop
   - IntelLustre option for a Hadoop Filesystem
   - MagpieNetworkFS option for a Hadoop Filesystem

Removed in Magpie 3.0

   - Spark 0.9.X support
   - Hbase 0.98.X and 0.99.X support
   - Mahout

Documentation
-------------

All documentation is in the 'doc' subdirectory.  Please see the
doc/README file as a starting point.  It provides general instructions
as well as pointers to documentation for each project, setup
requirements, ability to do local configurations, tips & tricks, and
more information.

Release
-------

Magpie is release under a GPL license. For more information, see the [COPYING](/COPYING) file.

`LLNL-CODE-644248`
