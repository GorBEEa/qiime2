#!/bin/sh

#SBATCH --job-name=00_qiime_01
#SBATCH --error=data/logs/%x-%j.err
#SBATCH --output=data/logs/%x-%j.out

#SBATCH --partition=general # This is the default partition
#SBATCH --qos=regular
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=10:00:00
#SBATCH --mem=24000

module load Python/Python-3.10.9-Anaconda3-2023.03-1
module load Mamba/23.1.0-4

# activate Qiime 2 environment

conda activate qiime2-amplicon-2024.10

#Input Directory
IN=/scratch/lchueca/gorbeea_genomic/microbiome_data/2023_DNA/qiime_ITS/data/raw
#Output Directory
OUT=demux_paired_end


qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path ${IN}/manifest_file.txt \
  --input-format PairedEndFastqManifestPhred33V2 \
  --output-path ${IN}/${OUT}.qza


  qiime demux summarize \
   --i-data ${IN}/${OUT}.qza \
   --o-visualization ${IN}/${OUT}.qzv