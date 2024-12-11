#!/bin/sh
#SBATCH --error err_%x_%j
#SBATCH --output out_%x_%j
#SBATCH --job-name merge
#SBATCH --mail-user xx@yy.zz
#SBATCH --mail-type END,FAIL
#SBATCH --cpus-per-task=1
#SBATCH -p Background

#Author Katie O'Mahony / 11/12/24
#Script to merge Illumina sequencing data across lanes
#Copy all raw fastq to one folder
mkdir raw_fastq
cp */*.gz raw_fastq

#Environmental variables
#Path to folder containing the raw reads
var_RAW_FASTQ=/path/on/primary/to/raw_fastq
#Path to output folder on analysis partition
var_MERGED_FASTQ=/path/on/analysis/to/raw_fastq

#generate samplenames.txt
ls $var_RAW_FASTQ/*_L001_R1_001.fastq.gz | sed "s|$var_RAW_FASTQ/||; s/_L001_R1_001.fastq.gz//" > samplenames.txt

mkdir -p $var_MERGED_FASTQ

#merge lanes 1 + 2 for each of the forward (R1) and reverse (R2) reads
for i in $(cat samplenames.txt); do
    cat $var_RAW_FASTQ/*"$i"*"_R1_001.fastq.gz" > $var_MERGED_FASTQ/"${i}_R1.fastq.gz"
    cat $var_RAW_FASTQ/*"$i"*"_R2_001.fastq.gz" > $var_MERGED_FASTQ/"${i}_R2.fastq.gz"
done
