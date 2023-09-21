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
