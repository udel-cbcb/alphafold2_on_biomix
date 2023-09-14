# AlphaFold2 on BIOMIX HPC Cluster
This repository hosts information about running AlphaFold2 on [BIOMIX HPC cluster](https://bioit.dbi.udel.edu/BIOMIX/BIOMIX-cluster.html) using singularity.

We have installed [AlphaFold2](https://github.com/google-deepmind/alphafold) on BIOMIX HPC Cluster based on [alphafold_singularity](https://github.com/prehensilecode/alphafold_singularity).

## Run as a Slurm job on BIOMIX 
See the example job script [`alphafold2_on_biomix_slurm.sh`](https://github.com/udel-cbcb/alphafold2_on_biomix/blob/main/alphafold2_on_biomix_slurm.sh).

Note: this example script must be modified to suit your specific needs. Only change the section mentioned below in the example slurm script.

### Customization for slurm enviroment
You can change your job name and add the following two SBATCH directives if you want to receive email notification of your job run status.

#SBATCH --job-name=afolds

#SBATCH --mail-user=youremail@university.edu

#SBATCH --mail-type=ALL

### Customization for input, output, and Alphafold2 model 
The next customization is to specify your input files and output directory. You need to provide your protein sequence in FASTA format. Each file only contains one sequence except a multi-sequence FASTA file for "multimer" model.

You also needs to change alphafold2 model by setting "--model_preset" parameter. Default is "monomer", but you can change it to "monomer_casp14", "monomer_ptm", or "multimer". 

### Submit job to BIOMIX
After finishing customization of the example job script [`alphafold2_on_biomix_slurm.sh`](https://github.com/udel-cbcb/alphafold2_on_biomix/blob/main/alphafold2_on_biomix_slurm.sh) to fit your needs, you can submit job to BIOMIX:

[chenc@biomix alphafold2_on_biomix]$ sbatch alphafold2_on_biomix_slurm.sh

After the job is successfully submitted, a log file named like "slurm-xxxxxx.out" will be created, please check this file for the status of your job and any error messages. You can also check the progress of your slurm job using command squeue. 

[chenc@biomix alphafold2_on_biomix]$ squeue | grep chenc 

### AlphaFold Output
Once your slurm job is finished successfully, go to the OUTPUT directory you specified in your slurm script to see AlphaFold outputs that include the computed MSAs, unrelaxed structures, relaxed structures, ranked structures, raw model outputs, prediction metadata, and section timings. Please see [official AlphaFold documentation](https://github.com/google-deepmind/alphafold#alphafold-output) for details.
