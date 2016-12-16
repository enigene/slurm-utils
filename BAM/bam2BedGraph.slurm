#!/bin/bash

#SBATCH --time=12:00:00
#SBATCH --output=slurm-%A.out
#SBATCH --error=slurm-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1

#SBATCH --job-name=bam2BedGraph

set -o pipefail
set -o errexit

module purge

source /data/software/exports

module load coreutils/8.21
module load bedtools/2.25.0

bamfiles=./*.bam

for file in $bamfiles; do
  fp="{file%.*}"
  bedtools genomecov -bg -ibam $file > $fp.bedgraph
  sort -k 1.4,1V -k 2,2n $fp.bedgraph > $fp.bedgraph.sorted
done
