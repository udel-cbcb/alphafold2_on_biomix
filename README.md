# AlphaFold2 on BIOMIX HPC Cluster
This repository hosts information about running AlphaFold2 (version: 2.3.2)on [BIOMIX HPC cluster](https://bioit.dbi.udel.edu/BIOMIX/BIOMIX-cluster.html) using singularity.

We have installed [AlphaFold2](https://github.com/google-deepmind/alphafold) on BIOMIX HPC Cluster based on [alphafold_singularity](https://github.com/prehensilecode/alphafold_singularity).

## Run as a Slurm job on BIOMIX 
See the example script [`alphafold2_on_biomix_slurm.sh`](https://github.com/udel-cbcb/alphafold2_on_biomix/blob/main/alphafold2_on_biomix_slurm.sh).

Note: this example script must be modified to suit your specific needs. Only change the section mentioned below in the example script.

### Customization for slurm environment
You can change your job name and add the following two SBATCH directives if you want to receive email notification of your job run status.

#SBATCH --job-name=afolds

#SBATCH --mail-user=youremail@university.edu

#SBATCH --mail-type=ALL

### Customization for input, output, and AlphaFold2 model 
The next customization is to specify your input files and output directory. You need to provide your protein sequence in FASTA format. Each file should contain only one sequence except for a multi-sequence FASTA file for the "multimer" model.

You also needs to change AlphaFold2 model by setting the "--model_preset" parameter. The default is "monomer", but you can change it to "monomer_casp14", "monomer_ptm", or "multimer". 

### Submit job to BIOMIX
Once you have finished customizing the example script [`alphafold2_on_biomix_slurm.sh`](https://github.com/udel-cbcb/alphafold2_on_biomix/blob/main/alphafold2_on_biomix_slurm.sh) to fit your needs, you can submit the job to BIOMIX using the following "sbatch" command:

[UserName@biomix alphafold2_on_biomix]$ sbatch alphafold2_on_biomix_slurm.sh

After the job is successfully submitted, a log file with a name like "slurm-xxxxxx.out" will be generated. Please review this file for the status of your job and any error messages. You can also monitor the progress of your slurm job using the "squeue" command. 

[UserName@biomix alphafold2_on_biomix]$ squeue | grep UserName 

### AlphaFold Output
Once your slurm job has successfully completed, navigate to the OUTPUT directory specified in your slurm script. There, you will find AlphaFold outputs including the computed MSAs, unrelaxed structures, relaxed structures, ranked structures, raw model outputs, prediction metadata, and section timings. Please refer to the [official AlphaFold documentation](https://github.com/google-deepmind/alphafold#alphafold-output) for more details.

### AlphaFold Command Flags (Short Version)

```
flags:

  --[no]benchmark: Run multiple JAX model evaluations to obtain a timing that excludes the compilation time, which should be more indicative of the time required for inferencing many proteins.
    (default: 'false')
  --data_dir: Path to directory with supporting data: AlphaFold parameters and genetic and template databases. Set to the target of download_all_databases.sh.
  --db_preset: <full_dbs|reduced_dbs>: Choose preset MSA database configuration - smaller genetic database config (reduced_dbs) or full genetic database config (full_dbs)
    (default: 'full_dbs')
  --docker_image_name: Name of the AlphaFold Docker image.
    (default: 'alphafold')
  --docker_user: UID:GID with which to run the Docker container. The output directories will be owned by this user:group. By default, this is the current user. Valid options are: uid or uid:gid, non-numeric values are
    not recognised by Docker unless that user has been created within the container.
    (default: '1268:1048')
  --[no]enable_gpu_relax: Run relax on GPU if GPU is enabled.
    (default: 'true')
  --fasta_paths: Paths to FASTA files, each containing a prediction target that will be folded one after another. If a FASTA file contains multiple sequences, then it will be folded as a multimer. Paths should be
    separated by commas. All FASTA paths must have a unique basename as the basename is used to name the output directories for each prediction.
    (a comma separated list)
  --gpu_devices: Comma separated list of devices to pass to NVIDIA_VISIBLE_DEVICES.
    (default: 'all')
  --max_template_date: Maximum template release date to consider (ISO-8601 format: YYYY-MM-DD). Important if folding historical test sets.
  --model_preset: <monomer|monomer_casp14|monomer_ptm|multimer>: Choose preset model configuration - the monomer model, the monomer model with extra ensembling, monomer model with pTM head, or multimer model
    (default: 'monomer')
  --models_to_relax: <best|all|none>: The models to run the final relaxation step on. If `all`, all models are relaxed, which may be time consuming. If `best`, only the most confident model is relaxed. If `none`,
    relaxation is not run. Turning off relaxation might result in predictions with distracting stereochemical violations but might help in case you are having issues with the relaxation stage.
    (default: 'best')
  --num_multimer_predictions_per_model: How many predictions (each with a different random seed) will be generated per model. E.g. if this is 2 and there are 5 models then there will be 10 predictions per input. Note:
    this FLAG only applies if model_preset=multimer
    (default: '5')
    (an integer)
  --output_dir: Path to a directory that will store the results.
    (default: '/scratch/tmp')
  --[no]use_gpu: Enable NVIDIA runtime to run with GPUs.
    (default: 'true')
  --[no]use_precomputed_msas: Whether to read MSAs that have been written to disk instead of running the MSA tools. The MSA files are looked up in the output directory, so it must stay the same between multiple runs
    that are to reuse the MSAs. WARNING: This will not check if the sequence, database or configuration have changed.
    (default: 'false')
```

### AlphaFold Command Flags (Full Version)

```
flags:

  --[no]benchmark: Run multiple JAX model evaluations to obtain a timing that excludes the compilation time, which should be more indicative of the time required for inferencing many proteins.
    (default: 'false')
  --data_dir: Path to directory with supporting data: AlphaFold parameters and genetic and template databases. Set to the target of download_all_databases.sh.
  --db_preset: <full_dbs|reduced_dbs>: Choose preset MSA database configuration - smaller genetic database config (reduced_dbs) or full genetic database config (full_dbs)
    (default: 'full_dbs')
  --docker_image_name: Name of the AlphaFold Docker image.
    (default: 'alphafold')
  --docker_user: UID:GID with which to run the Docker container. The output directories will be owned by this user:group. By default, this is the current user. Valid options are: uid or uid:gid, non-numeric values are
    not recognised by Docker unless that user has been created within the container.
    (default: '1268:1048')
  --[no]enable_gpu_relax: Run relax on GPU if GPU is enabled.
    (default: 'true')
  --fasta_paths: Paths to FASTA files, each containing a prediction target that will be folded one after another. If a FASTA file contains multiple sequences, then it will be folded as a multimer. Paths should be
    separated by commas. All FASTA paths must have a unique basename as the basename is used to name the output directories for each prediction.
    (a comma separated list)
  --gpu_devices: Comma separated list of devices to pass to NVIDIA_VISIBLE_DEVICES.
    (default: 'all')
  --max_template_date: Maximum template release date to consider (ISO-8601 format: YYYY-MM-DD). Important if folding historical test sets.
  --model_preset: <monomer|monomer_casp14|monomer_ptm|multimer>: Choose preset model configuration - the monomer model, the monomer model with extra ensembling, monomer model with pTM head, or multimer model
    (default: 'monomer')
  --models_to_relax: <best|all|none>: The models to run the final relaxation step on. If `all`, all models are relaxed, which may be time consuming. If `best`, only the most confident model is relaxed. If `none`,
    relaxation is not run. Turning off relaxation might result in predictions with distracting stereochemical violations but might help in case you are having issues with the relaxation stage.
    (default: 'best')
  --num_multimer_predictions_per_model: How many predictions (each with a different random seed) will be generated per model. E.g. if this is 2 and there are 5 models then there will be 10 predictions per input. Note:
    this FLAG only applies if model_preset=multimer
    (default: '5')
    (an integer)
  --output_dir: Path to a directory that will store the results.
    (default: '/scratch/tmp')
  --[no]use_gpu: Enable NVIDIA runtime to run with GPUs.
    (default: 'true')
  --[no]use_precomputed_msas: Whether to read MSAs that have been written to disk instead of running the MSA tools. The MSA files are looked up in the output directory, so it must stay the same between multiple runs
    that are to reuse the MSAs. WARNING: This will not check if the sequence, database or configuration have changed.
    (default: 'false')

absl.app:
  -?,--[no]help: show this help
    (default: 'false')
  --[no]helpfull: show full help
    (default: 'false')
  --[no]helpshort: show this help
    (default: 'false')
  --[no]helpxml: like --helpfull, but generates XML output
    (default: 'false')
  --[no]only_check_args: Set to true to validate args and exit.
    (default: 'false')
  --[no]pdb: Alias for --pdb_post_mortem.
    (default: 'false')
  --[no]pdb_post_mortem: Set to true to handle uncaught exceptions with PDB post mortem.
    (default: 'false')
  --profile_file: Dump profile information to a file (for python -m pstats). Implies --run_with_profiling.
  --[no]run_with_pdb: Set to true for PDB debug mode
    (default: 'false')
  --[no]run_with_profiling: Set to true for profiling the script. Execution will be slower, and the output format might change over time.
    (default: 'false')
  --[no]use_cprofile_for_profiling: Use cProfile instead of the profile module for profiling. This has no effect unless --run_with_profiling is set.
    (default: 'true')

absl.logging:
  --[no]alsologtostderr: also log to stderr?
    (default: 'false')
  --log_dir: directory to write logfiles into
    (default: '')
  --logger_levels: Specify log level of loggers. The format is a CSV list of `name:level`. Where `name` is the logger name used with `logging.getLogger()`, and `level` is a level name  (INFO, DEBUG, etc). e.g.
    `myapp.foo:INFO,other.logger:DEBUG`
    (default: '')
  --[no]logtostderr: Should only log to stderr?
    (default: 'false')
  --[no]showprefixforinfo: If False, do not prepend prefix to info messages when it's logged to stderr, --verbosity is set to INFO level, and python logging is used.
    (default: 'true')
  --stderrthreshold: log messages at this level, or more severe, to stderr in addition to the logfile.  Possible values are 'debug', 'info', 'warning', 'error', and 'fatal'.  Obsoletes --alsologtostderr. Using
    --alsologtostderr cancels the effect of this flag. Please also note that this flag is subject to --verbosity and requires logfile not be stderr.
    (default: 'fatal')
  -v,--verbosity: Logging verbosity level. Messages logged at this level or lower will be included. Set to 1 for debug logging. If the flag was not set or supplied, the value will be changed from the default of -1
    (warning) to 0 (info) after flags are parsed.
    (default: '-1')
    (an integer)

absl.flags:
  --flagfile: Insert flag definitions from the given file into the command line.
    (default: '')
  --undefok: comma-separated list of flag names that it is okay to specify on the command line even if the program does not define a flag with that name.  IMPORTANT: flags in this list that have arguments MUST use the
    --flag=value format.
    (default: '')
```
