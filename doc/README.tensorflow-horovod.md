Instructions For Running TensorFlow Horovod
-------------------------------------------

0) If necessary, download your favorite version of tensorflow and
   horovod.  Make sure it available on all nodes of your allocation
   (usually this means that it is installed in a NFS mounted path
   available on all nodes).

   Keep in mind that Magpie currently supports running TensorFlow
   Horovod using only Slurm and OpenMPI.

   (Optional) If you are going to run TF CNN benchmarks clone the benchmarks
   repository and place it under common path on all nodes:
   https://github.com/tensorflow/benchmarks/. Checkout onto the branch with
   the proper TF version (e.g. `git checkout cnn_tf_v1.12_compatible`).

1) Select an appropriate submission script for running your job.  You
   can find them in the directory submission-scripts/.

   At the moment, tensorflow w/ horovod is only supported on Slurm via
   sbatch & mpirun, so please start with the
   magpie.sbatch-mpirun-tensorflow-horovod sbatch file.

2) Setup your job essentials at the top of the submission script.

   #SBATCH --nodes=<nodes_nr> : Set how many nodes you want in your job

   #SBATCH --time=<time> : Set the time limit for this job to run (minutes)

   #SBATCH --job-name=<name> : Set the job's name

   #SBATCH --partition=<slurm-partition> : Set the partition to run the job in

   MAGPIE_SCRIPTS_HOME : Set the path to Magpie's repository

   MAGPIE_LOCAL_DIR : For scratch space files - should be already auto-filled

   MAGPIE_JOB_TYPE : This should be set to 'tensorflow-horovod'

3) Setup the essentials for TensorFlow and Horovod.

   TENSORFLOW_HOROVOD_SETUP : Set to yes

4) Select how your job will run by setting TENSORFLOW_HOROVOD_JOB. The first
   time you'll probably want to run w/ 'synthetic-benchmark' mode just to try
   things out and make sure things look correct.

5) Submit your job into the cluster by running
   `sbatch ./magpie.sbatch-mpirun` (Slurm support only).

6) Look at your job output file (slurm-%j.out by default for Slurm)
   to see your output.

TensorFlow Horovod Benchmarking (CNN Benchmark)
-----------------------------------------------

Using Magpie you can easily run TensorFlow Horovod benchmarks:
https://github.com/tensorflow/benchmarks/. To do so:

1) Follow the steps 0-3 from "Instructions For Running TensorFlow" section
   at first. Don't forget to clone the repository mentioned above in step 0.

2) Set the variables:

   TENSORFLOW_HOROVOD_JOB : Set the value to 'cnn-benchmark'.

   MAGPIE_TF_CNN_BENCHMARK_PY_FILE : Set the full path to the
                                     `scripts/tf_cnn_benchmarks/tf_cnn_benchmarks.py`
                                     file for your tensorflow/benchmarks
                                     repository cloned in step 0.

   MAGPIE_TF_CNN_BENCHMARK_PARAMETERS : Define your cnn benchmarks parameters,
                                        such as: '--batch_size=<single_batch_size>',
                                        '--num_batches=<number_of_batches>',
                                        '--model=resnet50' etc. See the description
                                        and the example in the run file.

3) Submit your job into the cluster by running
   `sbatch ./magpie.sbatch-mpirun` (Slurm support only).

4) Look at your job output file (slurm-%j.out by default for Slurm)
   to see your output.
