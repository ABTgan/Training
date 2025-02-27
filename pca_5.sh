#!/bin/bash
#$ -cwd           # Set the working directory for the job to the current directory
#$ -pe smp 1      # Request 1 cores
#$ -l h_rt=1:0:0  # Request 24 hours runtime 
#$ -l h_vmem=4G   # Request 4GB per core
#$ -m bea          # Send an email at the beggining, end (e) and if the job is aborted (a)
#$ -M bty647@qmul.ac.uk


module load python

# Create the Python script
cat <<EOL > /data/home/bty647/scripts/pcapythonver.py
import vcf
import pandas as pd
import numpy as np
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt

def vcf_to_dataframe(vcf_file):
    vcf_reader = vcf.Reader(open(vcf_file, 'r'))
    samples = vcf_reader.samples
    rows = []
    for record in vcf_reader:
        row = [record.CHROM, record.POS, record.REF, record.ALT]
        for sample in samples:
            genotype = record.genotype(sample)['GT']
            row.append(genotype)
        rows.append(row)
    columns = ['CHROM', 'POS', 'REF', 'ALT'] + samples
    df = pd.DataFrame(rows, columns=columns)
    return df

def genotype_to_numeric(genotype):
    if genotype == '0/0':
        return 0
    elif genotype == '0/1' or genotype == '1/0':
        return 1
    elif genotype == '1/1':
        return 2
    else:
        return np.nan

vcf_file = '/data/home/bty647/SW/Alkan2014/TGP.integrated_callset.vcf'
df = vcf_to_dataframe(vcf_file)

for sample in df.columns[4:]:
    df[sample] = df[sample].apply(genotype_to_numeric)

df = df.dropna()
data = df.iloc[:, 4:].T

pca = PCA(n_components=2)
principal_components = pca.fit_transform(data)
pca_df = pd.DataFrame(data=principal_components, columns=['PC1', 'PC2'])

plt.figure(figsize=(8, 6))
plt.scatter(pca_df['PC1'], pca_df['PC2'], edgecolor='k', s=50)
plt.xlabel('Principal Component 1')
plt.ylabel('Principal Component 2')
plt.title('PCA of VCF File')
plt.savefig('pca_plot.png')
plt.savefig('/data/home/bty647/SW/Alkan2014/temp/pca_plot.png')
EOL


# Run the Python script
python pcapythonver.py
