# alphafold2_singularity_on_biomix
This repository hosts information about running AlphaFold2 on [BIOMIX HPC cluster](https://bioit.dbi.udel.edu/BIOMIX/BIOMIX-cluster.html) using singularity.

We have installed [AlphaFold2](https://github.com/google-deepmind/alphafold) according to [alphafold_singularity](https://github.com/prehensilecode/alphafold_singularity).

## Run as a Slurm job on BIOMIX HPC cluster
See the example job script [`alphafold2_on_biomix_slurm.sh`](https://github.com/chenchuming/alphafold2_on_biomix/blob/main/alphafold2_on_biomix_slurm.sh).

Note: this example script must be modified to suit your specific needs.

### Customization for slurm enviriment
You can add the following two SBATCH directives if you want to receive email notification of your job run status 
#SBATCH --mail-user=youremail@university.edu
#SBATCH --mail-type=ALL
