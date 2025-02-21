#!/bin/bash
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 4      # Request 4 core
#$ -l h_rt= 5:0:0  # Request 5 hour runtime
#$ -l h_vmem=4G   # Request 4GB
#$ -m ea          # Send an email at the end (e) and if the job is aborted (a)
#$ -M bty647@qmul.ac.uk


echo "Script started at: $(date)"

#loading necessary modules
module load bcftools
module load plink


# Change to the directory containing the VCF files
cd /data/SBBS-FumagalliLab/SWAsia/Almarri2021/PHASED_VCFs

# Empty list to store VCF files
vcf_files=""

# Loop through each VCF file to add to list
for file in *.phased_variants.vcf.gz; do
    vcf_files="$vcf_files $file"
done

echo "Loop completed with files: $vcf_files"
echo "Time completed: $(date)"

# Merge all VCF files into one
bcftools merge $vcf_files -Oz -o merged_all_files.vcf.gz
    # -Oz: This option specifies that the output should be compressed in the BGZF (Block Gzip) format
    # -o: This option specifies the name of the output file.

echo "Merge completed at: $(date)"

# convert merged VCF file to PLINK format.
bcftools convert --plink merged_all_files.vcf.gz -o merged_all
    # command will create .bed, .bim, and .fam files, which are the binary PLINK format files.

echo "conversion completed at: $(date)"

# Create output directory since it doesn't exist
mkdir -p /data/home/bty647/output

# Perform PCA and save results in
my home directoryi
plink --bfile merged_all --pca --out /data/home/bty647/output/250220_PCA_results_Almarri2021

echo "script end at: $(date)"
