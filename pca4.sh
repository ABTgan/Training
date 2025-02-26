#!/bin/bash
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 4      # Request 4 cores
#$ -l h_rt=1:0:0  # Request 24 hours runtime 
#$ -l h_vmem=4G   # Request 4GB per core
#$ -m bea          # Send an email at the beggining, end (e) and if the job is aborted (a)
#$ -M bty647@qmul.ac.uk

echo "Script started at: $(date)"

# Load the PLINK module
module load plink
module load plink/2.00a6LM

# Change to the directory containing your data
cd /data/home/bty647/SW/Alkan2014

# Create the output directory if it doesn't exist
mkdir -p /data/home/bty647/output

# Convert VCF to PLINK binary format
plink2 --vcf TGP.integrated_callset.vcf --make-bed --out /data/home/bty647/output/plink_output --split-par b38

# Perform PCA analysis using PLINK2
plink2 --bfile /data/home/bty647/output/plink_output --pca --out /data/home/bty647/output/pca_results

echo "PCA analysis complete.
echo "Script ended at: $(date)"
