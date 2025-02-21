#!/bin/bash

# Create the output directory
mkdir -p /data/scratch/bty647/output_ch22

# Change to input directory
cd /data/SBBS-FumagalliLab/SWAsia/Almarri2021/PHASED_VCFs

# Loop through each VCF file and extract chromosome 22
for file in *.phased_variants.vcf.gz; do
  
  # Constructing output filename
  output="/data/scratch/bty647/output_ch22/chr22_${file}"
  
  # Extract chromosome 22 and save to the output file
  bcftools view "$file" --regions chr22 -Oz -o "$output"

  echo "Extraction complete for $file"

done


echo "**Extraction of chromosome 22 complete for all VCF files.**"
