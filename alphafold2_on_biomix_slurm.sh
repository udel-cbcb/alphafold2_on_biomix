#!/bin/bash
#SBATCH --job-name=afolds
#SBATCH --partition=gpu2
#SBATCH --account=gpu2
#SBATCH --mem=250G
#SBATCH --time=30-00:00

### NOTE
#### This job script cannot be used without modification for your specific environment.

# biomix specific, don't change
export ALPHAFOLD_DIR=/opt/alphafold_singularity
export ALPHAFOLD_DATADIR=/alphadb
export TMPDIR=/scratch/tmp

### Check values of some environment variables
echo ALPHAFOLD_DIR=$ALPHAFOLD_DIR
echo ALPHAFOLD_DATADIR=$ALPHAFOLD_DATADIR

#You can control which AlphaFold model to run by adding the --model_preset= flag. Alphafold provides the following models:
#
#	monomer: This is the original model used at CASP14 with no ensembling.
#
#	monomer_casp14: This is the original model used at CASP14 with num_ensemble=8, matching our CASP14 configuration. This is largely provided for reproducibility as it is 8x more computationally expensive for limited accuracy gain (+0.1 average GDT gain on CASP14 domains).
#
#	monomer_ptm: This is the original CASP14 model fine tuned with the pTM head, providing a pairwise confidence measure. It is slightly less accurate than the normal monomer model.
#
#	multimer: This is the AlphaFold-Multimer model. To use this model, provide a multi-sequence FASTA file. In addition, the UniProt database should have been downloaded.
#

#User customiazation for input files and output directories
#You need to provide your protein sequence in FASTA format. Each file only contains one sequence except a multi-sequence FASTA file for "multimer" model.
#OUTPUT=/home/chenc/alphafold_output
#INPUT=/home/chenc/alphafold_input/*.fasta
OUTPUT=
INPUT=


for file in $INPUT
do
filename=$(basename -- "$file")
# Run AlphaFold; default is to use GPUs
/usr/bin/python3 ${ALPHAFOLD_DIR}/run_singularity.py \
    --use_gpu \
    --data_dir=${ALPHAFOLD_DATADIR} \
    --fasta_paths=${file} \
    --max_template_date=2022-01-01 \
    --output_dir=${OUTPUT} \
    --model_preset=monomer \
    --db_preset=full_dbs

echo INFO: AlphaFold returned $?

### Copy Alphafold output back to directory where "sbatch" command was issued.
input_file_extension="${filename##*.}"
input_filename="${filename%.*}"

# This will create "coverage_LDDT.png" and "PAE.png" plots  
/usr/bin/python3 ${ALPHAFOLD_DIR}/visualize_alphafold_results.py --input_dir $TMPDIR/${input_filename}

cp -rp $TMPDIR/${input_filename} ${OUTPUT}
rm -rf $TMPDIR/*

done
