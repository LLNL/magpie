Magpie
------

Magpie contains a number of scripts for running Big Data software in
HPC environments.  Thus far, Hadoop, Spark, Hbase, Storm, Pig, Mahout,
Phoenix, Kafka, Zeppelin, and Zookeeper are supported.  It currently
supports running over the parallel file system Lustre and running over
any generic network filesytem.  There is scheduler/resource manager
support for Slurm, Moab, Torque, and LSF.

Some of the features presently supported:

- Run jobs interactively or via scripts.
- Run against a number of filesystem options, such as HDFS, HDFS over
  Lustre, HDFS over a generic network filesystem, Lustre directly, or
  a generic network filesystem.
- Take advantage of SSDs/NVRAM for local caching if available
- Run the UDA Infiniband optimization plugin for Hadoop.
- Make decent optimizations for your hardware

Basic Idea
----------

The basic idea behind these scripts are to:

1) Submit a Magpie batch script to allocate nodes on a cluster using
   your HPC scheduler/resource manager.  Slurm, Moab+Slurm,
   Moab+Torque and LSF+mpirun are currently supported.

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
   appropriate slave daemons, such as the Hadoop Datanodes.

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

The following packages and their versions have been tested for minimal
support in this version of Magpie.  Please see full README for
additional details.

Versions not listed below should work with Magpie if the
configuration/setup of those versions is compatible with the versions
listed below.  However, certain features or options may not work with
those versions.

* + - Requires patch against binary distro's scripts, no re-compilation needed
* ^ - Requires patch against source, requires re-compilation
* ! - Some issues may exist, see documentation for details

Hadoop - 2.1.0-beta+, 2.2.0+, 2.3.0+, 2.4.0+, 2.4.1+, 2.5.0+, 2.5.1+,
         2.5.2+, 2.6.0+, 2.6.1+, 2.6.2+, 2.6.3+, 2.6.4+, 2.6.5+,
         2.7.0+, 2.7.1+, 2.7.2+, 2.7.3+, 2.7.4+, 2.7.5+, 2.8.0+,
         2.8.1+, 2.8.2+, 2.8.3+, 2.8.4+, 2.9.0+, 2.9.1+

Spark - 0.9.1-bin-hadoop2+, 0.9.2-bin-hadoop2+, 1.0.0-bin-hadoop2^,
        1.1.0-bin-hadoop2.3+, 1.1.0-bin-hadoop2.4+,
        1.1.1-bin-hadoop2.3+, 1.1.1-bin-hadoop2.4+,
        1.2.0-bin-hadoop2.3+, 1.2.0-bin-hadoop2.4+,
        1.2.1-bin-hadoop2.3+, 1.2.1-bin-hadoop2.4+,
        1.2.2-bin-hadoop2.3+, 1.2.2-bin-hadoop2.4+,
        1.3.0-bin-hadoop2.3+, 1.3.0-bin-hadoop2.4+,
        1.3.1-bin-hadoop2.3+, 1.3.1-bin-hadoop2.4+,
        1.3.1-bin-hadoop2.6+, 1.4.0-bin-hadoop2.3+,
        1.4.0-bin-hadoop2.4+, 1.4.0-bin-hadoop2.6+,
        1.4.1-bin-hadoop2.3+, 1.4.1-bin-hadoop2.4+,
        1.4.1-bin-hadoop2.6+, 1.5.0-bin-hadoop2.6+,
        1.5.1-bin-hadoop2.6+, 1.5.2-bin-hadoop2.6+,
        1.6.0-bin-hadoop2.6+, 1.6.1-bin-hadoop2.6+,
        1.6.2-bin-hadoop2.6+, 1.6.3-bin-hadoop2.6+,
        2.0.0-bin-hadoop2.6+, 2.0.0-bin-hadoop2.7+,
        2.0.1-bin-hadoop2.6+, 2.0.1-bin-hadoop2.7+,
        2.0.2-bin-hadoop2.6+, 2.0.2-bin-hadoop2.7+,
        2.1.0-bin-hadoop2.6+, 2.1.0-bin-hadoop2.7+,
        2.1.1-bin-hadoop2.6+, 2.1.1-bin-hadoop2.7+,
        2.1.2-bin-hadoop2.6+, 2.1.2-bin-hadoop2.7+,
        2.2.0-bin-hadoop2.6+!, 2.2.0-bin-hadoop2.7+!,
        2.2.1-bin-hadoop2.6+!, 2.2.1-bin-hadoop2.7+!,
        2.3.0-bin-hadoop2.6+!, 2.3.0-bin-hadoop2.7+!,

Hbase - 0.96.1.1-hadoop2+, 0.98.0-hadoop2+, 0.98.1-hadoop2+,
        0.98.2-hadoop2+, 0.98.3-hadoop2+, 0.98.4-hadoop2+,
        0.98.5-hadoop2+, 0.98.6-hadoop2+, 0.98.6.1-hadoop2+,
        0.98.7-hadoop2+, 0.98.8-hadoop2+, 0.98.9-hadoop2+,
        0.98.10-hadoop2+, 0.98.10.1-hadoop2+, 0.98.11-hadoop2+,
        0.98.12-hadoop2+, 0.98.12.1-hadoop2+, 0.98.13-hadoop2+,
        0.98.14-hadoop2+, 0.98.15-hadoop2+, 0.98.16-hadoop2+,
        0.98.16.1-hadoop2+, 0.98.17-hadoop2+, 0.98.18-hadoop2+,
        0.98.19-hadoop2+, 0.98.20-hadoop2+, 0.98.21-hadoop2+,
        0.98.22-hadoop2+, 0.98.23-hadoop2+, 0.98.24-hadoop2+, 0.99.0+,
        0.99.1+, 0.99.2+, 1.0.0+, 1.0.1+, 1.0.1.1+, 1.0.2+, 1.0.3+,
        1.1.0+, 1.1.0.1+, 1.1.1+, 1.1.2+, 1.1.3+, 1.1.4+, 1.1.5+,
        1.1.6+, 1.1.7+, 1.1.8+, 1.1.9+, 1.1.10+, 1.1.11+, 1.1.12+,
        1.1.13+, 1.2.0+, 1.2.1+, 1.2.2+, 1.2.3+, 1.2.4+, 1.2.5+,
        1.2.6+, 1.3.0+, 1.3.1+, 1.4.0+!, 1.4.1+, 1.4.2+, 1.4.3+,
        1.4.4+

Pig - 0.12.0, 0.12.1, 0.13.0, 0.14.0, 0.15.0, 0.16.0, 0.17.0 [PigNote]

Zookeeper - 3.4.0, 3.4.1, 3.4.2, 3.4.3, 3.4.4, 3.4.5, 3.4.6, 3.4.7,
            3.4.8, 3.4.9, 3.4.10, 3.4.11, 3.4.12

Storm - 0.9.2^, 0.9.3, 0.9.4, 0.9.5, 0.9.6, 0.9.7, 0.10.0, 0.10.1,
        0.10.2, 1.0.0, 1.0.1, 1.0.2, 1.0.3, 1.0.4, 1.1.0, 1.1.1,
        1.1.2, 1.2.0, 1.2.1

Mahout - 0.11.0+, 0.11.1+, 0.11.2+, 0.12.0+, 0.12.1+, 0.12.2, 0.13.0

Phoenix - 4.5.0-Hbase-1.0+, 4.5.0-Hbase-1.1+, 4.5.1-Hbase-1.0+,
          4.5.1-Hbase-1.1+, 4.5.2-HBase-1.0+, 4.5.2-HBase-1.1+,
          4.6.0-Hbase-1.0+, 4.6.0-Hbase-1.1, 4.7.0-Hbase-1.0+,
          4.7.0-Hbase-1.1, 4.8.0-Hbase-1.0+, 4.8.0-Hbase-1.1,
          4.8.0-Hbase-1.2, 4.8.1-Hbase-1.0+, 4.8.1-Hbase-1.1,
          4.8.1-Hbase-1.2, 4.8.2-Hbase-1.0+, 4.8.2-Hbase-1.1,
          4.8.2-Hbase-1.2, 4.9.0-Hbase-1.1, 4.9.0-Hbase-1.2,
          4.10.0-Hbase-1.1, 4.10.0-Hbase-1.2, 4.11.0-Hbase-1.1,
          4.11.0-Hbase-1.2, 4.11.0-Hbase-1.3, 4.12.0-Hbase-1.1,
          4.12.0-Hbase-1.2, 4.12.0-Hbase-1.3, 4.13.0-Hbase-1.3,
          4.13.1-Hbase-1.1, 4.13.1-Hbase-1.2, 4.13.1-Hbase-1.3

Kafka - 2.11-0.9.0.0

Zeppelin - 0.5.6-incubating, 0.6.0, 0.6.1, 0.6.2, 0.7.0, 0.7.1, 0.7.2,
           0.7.3

[PigNote] - Default Pig build for versions 0.12.X is Hadoop 0.20 or
      1.X, so recompilation may be necessary depending on your
      environment.

Older Supported Packages & Features
-----------------------------------

Some packages and features were dropped in Magpie 2.0 due to lack of
interest, the software becoming old/deprecated, and/or their initial
experimental addition into Magpie.  If you are interested in them,
please look at Magpie 1.X versions for supported versions and
documentation.  If you are very interested in support in Magpie 2.0
beyond an experimental nature, please submit a support request and we
can reconsider adding it back in.

   - Hadoop 1.X support
   - Tachyon
   - UDA/uda-plugin for Hadoop
   - HDFS Federation in Hadoop
   - IntelLustre option for a Hadoop Filesystem
   - MagpieNetworkFS option for a Hadoop Filesystem

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
