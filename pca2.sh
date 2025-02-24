#!/bin/bash
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 4      # Request 4 cores
#$ -l h_rt=24:0:0  # Request 24 hours runtime (no space after =)
#$ -l h_vmem=4G   # Request 4GB per core
#$ -m bea          # Send an email at the beggining, end (e) and if the job is aborted (a)
#$ -M bty647@qmul.ac.uk


# Set the job array size based on the number of VCF files
#$ -t 1-40  # Array job to process the exact number of valid files

echo "Script started at: $(date)"

# Load necessary modules
module load vcftools
module load plink

# Change to the directory containing the VCF files
cd /data/SBBS-FumagalliLab/SWAsia/Almarri2021/PHASED_VCFs

# Get list of VCF files
vcf_files=(*.phased_variants.vcf.gz)

# Check if the current task ID exceeds the number of files
if [ $SGE_TASK_ID -gt ${#vcf_files[@]} ]; then
    echo "No file to process for task ID: $SGE_TASK_ID"
    exit 0
fi

file=${vcf_files[$SGE_TASK_ID-1]}
echo "Processing file: $file"

# Create output directory
mkdir -p /data/scratch/bty647/output_almarri_plinkform

# Convert each VCF file to PLINK format and save in the Scratch
vcftools --gzvcf $file --plink --out /data/scratch/bty647/output_almarri_plinkform/${file%.vcf.gz}

echo "Conversion completed for: $file at: $(date)"

# Check if this is the last task in the array
if [ $SGE_TASK_ID -eq ${#vcf_files[@]} ]; then
    mkdir -p /data/home/bty647/output
    mkdir -p /data/home/bty647/output/almarri2021

    echo "Directories made"

    # Merge all PLINK files into one and save
    ls /data/scratch/bty647/output_almarri_plinkform/*.bed | sed 's/.bed//' > /data/home/bty647/output/almarri2021/plink_files.txt
    plink --merge-list /data/home/bty647/output/almarri2021/plink_files.txt --make-bed --out /data/home/bty647/output/almarri2021/merged_all

    echo "Merge completed at: $(date)"

    # Perform PCA
    plink --bfile /data/home/bty647/output/almarri2021/merged_all --pca --out /data/home/bty647/output/almarri2021/250221_PCA_results_Almarri2021

    echo "Script ended at: $(date)"
fi
