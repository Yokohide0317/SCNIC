#!/bin/bash

set -e
set -u

INP_TABLE=$1 #"../../metagenome/merge/merged-table.qza"
INP_TAXONOMY=$2 #"../../metagenome/merge/taxonomy.qza"

echo "Table: ${INP_TABLE}"
echo "Taxonomy: ${INP_TAXONOMY}"

ROOT_OUTDIR="./q2_to_SCNIC"
if [ ! -d ${ROOT_OUTDIR} ]; then
    mkdir ${ROOT_OUTDIR}
fi


for LEVEL in {1..7}; do
    LEVEL_OUTDIR="${ROOT_OUTDIR}/L${LEVEL}"
    if [ ! -d ${LEVEL_OUTDIR} ]; then
        mkdir ${LEVEL_OUTDIR}
    fi

    qiime taxa collapse \
        --i-table ${INP_TABLE} \
        --i-taxonomy ${INP_TAXONOMY} \
        --p-level ${LEVEL} \
        --o-collapsed-table ${LEVEL_OUTDIR}/collapsed_table.qza

    qiime tools export \
        --input-path ${LEVEL_OUTDIR}/collapsed_table.qza \
        --output-path ${LEVEL_OUTDIR}/exported-feature-table
done

echo "--------------------------------"
echo "Ready to make network."
echo "Please do 'conda activate SCNIC' and 'bash 02_SCNIC.sh ${ROOT_OUTDIR}'"