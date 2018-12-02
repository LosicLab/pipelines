#!/bin/bash

# The purpose of this script is to run the LosicLab's custom fork of nextflow's wholeexome sequencing processing pipeline for fastq->vcf.


# specify account for lsf runs
account='acc_JanssenIBD' # do not leave this to default unless running interactive profile
job_queue='premium' #default queue is alloc

# Run directory. Pipeline outputs to $rundir/Processed
rundir='/sc/orga/projects/losicb01a/common_folder/nextflow-pipelines/wxs-test'

# Reference genome to use [Default: GRCh38; other refs not yet supported]
ref="GRCh38"

# Path to directory containing the pipeline to run
pipeline='/sc/orga/projects/losicb01a/common_folder/nextflow-pipelines/exoseq'
mkdir -p $rundir
cd $rundir

inputBAM="$rundir/preprocessing/bwamem-Align/Sample*"

module load nextflow/0.30.2
#NXF_OPTS='-Xms1g'

#while read line ; do

#    sampleID=${line##/sc*/}
#    echo $sampleID

nextflow run $pipeline/bamQC.nf \
--outdir $rundir/bamQC \
--bam "$inputBAM" \
--genome $ref \
--saveAlignedIntermediates true \
--minerva_account $account \
--multiLane false \
--job_queue $job_queue \
-resume \
-profile standard


#done<list
