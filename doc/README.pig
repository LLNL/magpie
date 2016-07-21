Instructions For Using Pig
--------------------------

0) If necessary, download your favorite version of Pig off of Apache
   and install it into a location where it's accessible on all cluster
   nodes.  Usually this is on a NFS home directory.

   Make sure that the version of Pig you install is compatible with
   the version of Hadoop you are using.

   See below in 'Pig Patching' about patches that may be necessary
   for Pig depending on your environment and Pig version.

   In some cases, a re-compile of Pig may be necessary.  For example,
   by default Pig 0.12.0 works against the 0.20.0 (i.e. Hadoop 1.0)
   branch of Hadoop.  You may need to modify the Pig build.xml to work
   with the 0.23.0 branch (i.e. Hadoop 2.0).

   See 'Convenience Scripts' in README about
   misc/magpie-apache-download-and-setup.sh, which may make the
   downloading and patching easier.

1) Select an appropriate submission script for running your job.  You
   can find them in the directory submission-scripts/, with Slurm
   Sbatch scripts using srun in script-sbatch-srun, Moab Msub+Slurm
   scripts using srun in script-msub-slurm-srun, Moab Msub+Torque
   scripts using pdsh in script-msub-torque-pdsh, and LSF scripts
   using mpirun in script-lsf-mpirun.

   You'll likely want to start with the base hadoop+pig script
   (e.g. magpie.sbatch-srun-hadoop-and-pig) for your
   scheduler/resource manager.  If you wish to configure more, you can
   choose to start with the base script (e.g. magpie.sbatch-srun)
   which contains all configuration options.

2) Setup your job essentials at the top of the submission script.  As
   an example, the following are the essentials for running with Moab.

   #MSUB -l nodes : Set how many nodes you want in your job

   #MSUB -l walltime : Set the time for this job to run

   #MSUB -l partition : Set the job partition

   #MSUB -q <my batch queue> : Set to batch queue

   MOAB_JOBNAME : Set your job name.

   MAGPIE_SCRIPTS_HOME : Set where your scripts are

   MAGPIE_LOCAL_DIR : For scratch space files

   MAGPIE_JOB_TYPE : This should be set to 'pig' initially

   JAVA_HOME : B/c you need to ...

3) Setup the essentials for Pig.

   PIG_SETUP : Set to yes

   PIG_VERSION : Set appropriately.

   PIG_HOME : Where your pig code is.  Typically in an NFS mount.

   PIG_LOCAL_DIR : A small place for conf files and log files local to
   each node.  Typically /tmp directory.

4) Select how your job will run by setting MAGPIE_JOB_TYPE and/or
   PIG_JOB.  Initially, you'll likely want to set MAGPIE_JOB_TYPE to
   'pig' and setting PIG_JOB to 'testpig'.  This will allow you to run
   a pre-written job to make sure things are setup correctly.

   After this, you may want to run with MAGPIE_JOB_TYPE set to
   'interactive' to play around and figure things out.  See
   instructions under README.hadoop for 'interactive' mode.

   Once in your session, you can do as you please.  For example, you
   can launch a pig job (bin/pig ...).  There will also be
   instructions in your job output on how to tear the session down
   cleanly if you wish to end your job early.

   Once you have figured out how you wish to run your job, you will
   likely want to run with 'script' mode.  Create a Pig script and set
   it in PIG_SCRIPT_PATH, and then run your job.  

   See "Exported Environment Variables" in README for information on
   common exported environment variables that may be useful in
   scripts.

   See below in "Pig Exported Environment Variables", for information
   on Pig specific exported environment variables that may be useful
   in scripts.

5) Pig requires Hadoop, so ensure the Hadoop is configured and also in
   your submission script.  See README.hadoop for Hadoop setup
   instructions.

6) Submit your job into the cluster by running "sbatch -k
   ./magpie.sbatchfile" for Slurm, "msub ./magpie.msubfile" for
   Moab, or "bsub < .magpie.lsffile" for LSF.
   Add any other options you see fit.

7) Look at your job output file to see your output.  There will also
   be some notes/instructions/tips in the output file for viewing the
   status of your job in a web browser, environment variables you wish
   to set if interacting with it, etc.

   See "General Advanced Usage" in README for additional tips.

Pig Exported Environment Variables
----------------------------------

The following environment variables are exported when your job is run
and may be useful in scripts in your run or in pre/post run scripts.

PIG_CONF_DIR : the directory that Pig configuration files
               local to the node are stored.

See "Hadoop Exported Environment Variables" in README.hadoop, for
Hadoop environment variables that may be useful.

Pig Patching
------------
- A major bug exists in 0.12.0, which most users may wish to patch and
  recompile.

  https://issues.apache.org/jira/browse/PIG-3512

  It would be wise to recompile 0.12.0 with this fix.
