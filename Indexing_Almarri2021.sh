#!/bin/bash
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 1      # Request 1 core
#$ -l h_rt=1:0:0  # Request 1 hour runtime
#$ -l h_vmem=4G   # Request 4GB


# Change to the directory containing the VCF files
cd /data/SBBS-FumagalliLab/SWAsia/Almarri2021/PHASED_VCFs

#Loading necessary modules
module load bcftools

# Loop through each VCF file and create an index
for file in *.phased_variants.vcf.gz; do
  # Index the VCF file
  bcftools index "$file"
  echo "Indexing complete for $file"
done

echo "Indexing complete for all VCF files."
