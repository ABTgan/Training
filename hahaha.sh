#!/bin/bash
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 1      # Request 4 cores
#$ -l h_rt=1:0:0  # Request 24 hours runtime
#$ -l h_vmem=4G # Request 4GB per core
#$ -m bea          # Send an email at the beggining, end (e) and if the job is aborted (a)
#$ -M bty647@qmul.ac.uk

echo "Script started at: $(date)"

# Load the PLINK module
module load plink/2.00a6LM
module load bcftools

INPUT=/data/SBBS-FumagalliLab/SWAsia/Retrotransposons/HGDP/hgdp_wgs.20190516.full.chr21.vcf.gz
OUTPUT=/data/home/bty647/output

# Step 1: Fix Duplicate IDs
bcftools annotate --set-id +'%CHROM:%POS' $INPUT -Oz -o $OUTPUT/hgdp_fixed21.vcf.gz
tabix -p vcf $OUTPUT/hgdp_fixed21.vcf.gz

# Step 2: Linkage Pruning
plink2 --vcf $OUTPUT/hgdp_fixed21.vcf.gz --double-id --set-all-var-ids @:# \
  --indep-pairwise 50 5 0.1 --max-alleles 2 --make-bed --out $OUTPUT/prune21

# Step 3: PCA Analysis
plink2 --bfile $OUTPUT/prune21 --extract $OUTPUT/prune21.prune.in \
  --make-bed --pca --out $OUTPUT/pca

echo "Script finished at: $(date)"
