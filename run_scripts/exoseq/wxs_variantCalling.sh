#!/bin/bash

# The purpose of this script is to run the LosicLab's custom fork of nextflow's wholeexome sequencing processing pipeline for fastq->vcf.


# specify account for lsf runs
account='acc_JanssenIBD' # do not leave this to default unless running interactive profile
job_queue='premium' #default queue is alloc

# Run directory. Pipeline outputs to $rundir/VariantCalling
rundir='/sc/orga/projects/losicb01a/common_folder/nextflow-pipelines/wxs-test'

# Reference genome to use [Default: GRCh38; other refs not yet supported]
ref="GRCh38"

# Path to directory containing the pipeline to run
pipeline='/sc/orga/projects/losicb01a/common_folder/nextflow-pipelines/exoseq'
mkdir -p $rundir
cd $rundir


nID='' # identifier for normal sample
tID='' # identifier for tumor sample
       # (leave blank & comment out lines using this variable if no somatic mutation calling)

nbam=$rundir"/"$nID"*.bam"
tbam=$rundir"/"$tID"*.bam"

module load nextflow/0.30.2

nextflow run $pipeline/variantCalling.nf \
--outdir $rundir/variantCalling \
-w $rundir/variantCalling_temp \
--nbam "$nbam" \
--tbam "$tbam" \
--genome $ref \
--minerva_account $account \
--job_queue $job_queue \
-resume \
-profile standard